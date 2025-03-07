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
      module IndexLifecycleManagement
        module Actions
          # Retrieves information about the index's current lifecycle state, such as the currently executing phase, action, and step.
          #
          # @option arguments [String] :index The name of the index to explain
          # @option arguments [Boolean] :only_managed filters the indices included in the response to ones managed by ILM
          # @option arguments [Boolean] :only_errors filters the indices included in the response to ones in an ILM error state, implies only_managed
          # @option arguments [Hash] :headers Custom HTTP headers
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.17/ilm-explain-lifecycle.html
          #
          def explain_lifecycle(arguments = {})
            raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]

            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _index = arguments.delete(:index)

            method = Elasticsearch::API::HTTP_GET
            path   = "#{Elasticsearch::API::Utils.__listify(_index)}/_ilm/explain"
            params = Elasticsearch::API::Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

            body = nil
            perform_request(method, path, params, body, headers).body
          end

          # Register this action with its valid params when the module is loaded.
          #
          # @since 6.2.0
          ParamsRegistry.register(:explain_lifecycle, [
            :only_managed,
            :only_errors
          ].freeze)
        end
      end
    end
  end
end
