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
          # Creates an inference trained model.
          #
          # @option arguments [String] :model_id The ID of the trained models to store
          # @option arguments [Boolean] :defer_definition_decompression If set to `true` and a `compressed_definition` is provided, the request defers definition decompression and skips relevant validations.
          # @option arguments [Hash] :headers Custom HTTP headers
          # @option arguments [Hash] :body The trained model configuration (*Required*)
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.17/put-trained-models.html
          #
          def put_trained_model(arguments = {})
            raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
            raise ArgumentError, "Required argument 'model_id' missing" unless arguments[:model_id]

            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _model_id = arguments.delete(:model_id)

            method = Elasticsearch::API::HTTP_PUT
            path   = "_ml/trained_models/#{Elasticsearch::API::Utils.__listify(_model_id)}"
            params = Elasticsearch::API::Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

            body = arguments[:body]
            perform_request(method, path, params, body, headers).body
          end

          # Register this action with its valid params when the module is loaded.
          #
          # @since 6.2.0
          ParamsRegistry.register(:put_trained_model, [
            :defer_definition_decompression
          ].freeze)
        end
      end
    end
  end
end
