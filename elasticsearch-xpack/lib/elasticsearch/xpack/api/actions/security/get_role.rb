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
      module Security
        module Actions
          # Retrieves roles in the native realm.
          #
          # @option arguments [List] :name A comma-separated list of role names
          # @option arguments [Hash] :headers Custom HTTP headers
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.17/security-api-get-role.html
          #
          def get_role(arguments = {})
            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _name = arguments.delete(:name)

            method = Elasticsearch::API::HTTP_GET
            path   = if _name
                       "_security/role/#{Elasticsearch::API::Utils.__listify(_name)}"
                     else
                       "_security/role"
                     end
            params = {}

            body = nil
            if Array(arguments[:ignore]).include?(404)
              Elasticsearch::API::Utils.__rescue_from_not_found { perform_request(method, path, params, body, headers).body }
            else
              perform_request(method, path, params, body, headers).body
            end
          end
        end
      end
    end
  end
end
