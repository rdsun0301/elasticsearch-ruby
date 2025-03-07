# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

module Elasticsearch
  module XPack
    module API
      module MachineLearning
        module Actions
          # Retrieves anomaly records for an anomaly detection job.
          #
          # @option arguments [String] :job_id The ID of the job
          # @option arguments [Boolean] :exclude_interim Exclude interim results
          # @option arguments [Integer] :from skips a number of records
          # @option arguments [Integer] :size specifies a max number of records to get
          # @option arguments [String] :start Start time filter for records
          # @option arguments [String] :end End time filter for records
          # @option arguments [Double] :record_score Returns records with anomaly scores greater or equal than this value
          # @option arguments [String] :sort Sort records by a particular field
          # @option arguments [Boolean] :desc Set the sort direction
          # @option arguments [Hash] :headers Custom HTTP headers
          # @option arguments [Hash] :body Record selection criteria
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.17/ml-get-record.html
          #
          def get_records(arguments = {})
            raise ArgumentError, "Required argument 'job_id' missing" unless arguments[:job_id]

            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _job_id = arguments.delete(:job_id)

            method = if arguments[:body]
                       Elasticsearch::API::HTTP_POST
                     else
                       Elasticsearch::API::HTTP_GET
                     end

            path = "_ml/anomaly_detectors/#{Elasticsearch::API::Utils.__listify(_job_id)}/results/records"
            params = Elasticsearch::API::Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

            body = arguments[:body]
            perform_request(method, path, params, body, headers).body
          end

          # Register this action with its valid params when the module is loaded.
          #
          # @since 6.2.0
          ParamsRegistry.register(:get_records, [
            :exclude_interim,
            :from,
            :size,
            :start,
            :end,
            :record_score,
            :sort,
            :desc
          ].freeze)
        end
      end
    end
  end
end
