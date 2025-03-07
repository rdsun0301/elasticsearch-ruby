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
          # Starts a data frame analytics job.
          #
          # @option arguments [String] :id The ID of the data frame analytics to start
          # @option arguments [Time] :timeout Controls the time to wait until the task has started. Defaults to 20 seconds
          # @option arguments [Hash] :headers Custom HTTP headers
          # @option arguments [Hash] :body The start data frame analytics parameters
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.17/start-dfanalytics.html
          #
          def start_data_frame_analytics(arguments = {})
            raise ArgumentError, "Required argument 'id' missing" unless arguments[:id]

            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _id = arguments.delete(:id)

            method = Elasticsearch::API::HTTP_POST
            path   = "_ml/data_frame/analytics/#{Elasticsearch::API::Utils.__listify(_id)}/_start"
            params = Elasticsearch::API::Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

            body = arguments[:body]
            perform_request(method, path, params, body, headers).body
          end

          # Register this action with its valid params when the module is loaded.
          #
          # @since 6.2.0
          ParamsRegistry.register(:start_data_frame_analytics, [
            :timeout
          ].freeze)
        end
      end
    end
  end
end
