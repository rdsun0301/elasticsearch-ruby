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
#
# Auto generated from build hash f284cc16f4d4b4289bc679aa1529bb504190fe80
# @see https://github.com/elastic/elasticsearch/tree/main/rest-api-spec
#
module Elasticsearch
  module API
    module Watcher
      module Actions
        # Removes a watch from Watcher.
        #
        # @option arguments [String] :id Watch ID
        # @option arguments [Hash] :headers Custom HTTP headers
        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/8.12/watcher-api-delete-watch.html
        #
        def delete_watch(arguments = {})
          request_opts = { endpoint: arguments[:endpoint] || "watcher.delete_watch" }

          defined_params = [:id].inject({}) do |set_variables, variable|
            set_variables[variable] = arguments[variable] if arguments.key?(variable)
            set_variables
          end
          request_opts[:defined_params] = defined_params unless defined_params.empty?

          raise ArgumentError, "Required argument 'id' missing" unless arguments[:id]

          arguments = arguments.clone
          headers = arguments.delete(:headers) || {}

          body = nil

          _id = arguments.delete(:id)

          method = Elasticsearch::API::HTTP_DELETE
          path   = "_watcher/watch/#{Utils.__listify(_id)}"
          params = Utils.process_params(arguments)

          if Array(arguments[:ignore]).include?(404)
            Utils.__rescue_from_not_found {
              Elasticsearch::API::Response.new(
                perform_request(method, path, params, body, headers, request_opts)
              )
            }
          else
            Elasticsearch::API::Response.new(
              perform_request(method, path, params, body, headers, request_opts)
            )
          end
        end
      end
    end
  end
end
