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
          # Previews that will be analyzed given a data frame analytics config.
          #
          # @option arguments [String] :id The ID of the data frame analytics to preview
          # @option arguments [Hash] :headers Custom HTTP headers
          # @option arguments [Hash] :body The data frame analytics config to preview
          #
          # @see http://www.elastic.co/guide/en/elasticsearch/reference/7.17/preview-dfanalytics.html
          #
          def preview_data_frame_analytics(arguments = {})
            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _id = arguments.delete(:id)

            method = if arguments[:body]
                       Elasticsearch::API::HTTP_POST
                     else
                       Elasticsearch::API::HTTP_GET
                     end

            path   = if _id
                       "_ml/data_frame/analytics/#{Elasticsearch::API::Utils.__listify(_id)}/_preview"
                     else
                       "_ml/data_frame/analytics/_preview"
                     end
            params = {}

            body = arguments[:body]
            perform_request(method, path, params, body, headers).body
          end
        end
      end
    end
  end
end
