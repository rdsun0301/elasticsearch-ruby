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
      module CrossClusterReplication
        module Actions
          # Retrieves follower stats. return shard-level stats about the following tasks associated with each shard for the specified indices.
          #
          # @option arguments [List] :index A comma-separated list of index patterns; use `_all` to perform the operation on all indices
          # @option arguments [Hash] :headers Custom HTTP headers
          #
          # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.17/ccr-get-follow-stats.html
          #
          def follow_stats(arguments = {})
            raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]

            headers = arguments.delete(:headers) || {}

            arguments = arguments.clone

            _index = arguments.delete(:index)

            method = Elasticsearch::API::HTTP_GET
            path   = "#{Elasticsearch::API::Utils.__listify(_index)}/_ccr/stats"
            params = {}

            body = nil
            perform_request(method, path, params, body, headers).body
          end
        end
      end
    end
  end
end
