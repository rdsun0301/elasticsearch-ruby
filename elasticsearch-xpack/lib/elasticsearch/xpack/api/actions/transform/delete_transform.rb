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
      module Transform
        module Actions
          # Deletes an existing transform.
          #
          # @option arguments [String] :transform_id The id of the transform to delete
          # @option arguments [Boolean] :force When `true`, the transform is deleted regardless of its current state. The default value is `false`, meaning that the transform must be `stopped` before it can be deleted.
          # @option arguments [Time] :timeout Controls the time to wait for the transform deletion
          # @option arguments [Hash] :headers Custom HTTP headers
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.17/delete-transform.html
          #
          def delete_transform(arguments = {})
            raise ArgumentError, "Required argument 'transform_id' missing" unless arguments[:transform_id]

            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _transform_id = arguments.delete(:transform_id)

            method = Elasticsearch::API::HTTP_DELETE
            path   = "_transform/#{Elasticsearch::API::Utils.__listify(_transform_id)}"
            params = Elasticsearch::API::Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

            body = nil
            perform_request(method, path, params, body, headers).body
          end

          # Register this action with its valid params when the module is loaded.
          #
          # @since 6.2.0
          ParamsRegistry.register(:delete_transform, [
            :force,
            :timeout
          ].freeze)
        end
      end
    end
  end
end
