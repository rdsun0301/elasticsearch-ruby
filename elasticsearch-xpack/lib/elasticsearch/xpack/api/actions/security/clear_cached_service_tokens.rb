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
          # Evicts tokens from the service account token caches.
          #
          # @option arguments [String] :namespace An identifier for the namespace
          # @option arguments [String] :service An identifier for the service name
          # @option arguments [List] :name A comma-separated list of service token names
          # @option arguments [Hash] :headers Custom HTTP headers
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.17/security-api-clear-service-token-caches.html
          #
          def clear_cached_service_tokens(arguments = {})
            raise ArgumentError, "Required argument 'namespace' missing" unless arguments[:namespace]
            raise ArgumentError, "Required argument 'service' missing" unless arguments[:service]
            raise ArgumentError, "Required argument 'name' missing" unless arguments[:name]

            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _namespace = arguments.delete(:namespace)

            _service = arguments.delete(:service)

            _name = arguments.delete(:name)

            method = Elasticsearch::API::HTTP_POST
            path   = "_security/service/#{Elasticsearch::API::Utils.__listify(_namespace)}/#{Elasticsearch::API::Utils.__listify(_service)}/credential/token/#{Elasticsearch::API::Utils.__listify(_name)}/_clear_cache"
            params = {}

            body = nil
            perform_request(method, path, params, body, headers).body
          end
        end
      end
    end
  end
end
