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
  module DSL
    module Search
      module Queries

        # A filter which returns parent documents for children documents matching a query
        #
        # @example Return articles with comments mentioning 'twitter', summing the score
        #
        #     search do
        #       query do
        #         top_children do
        #           type  'comment'
        #           query match: { body: 'twitter' }
        #           score 'sum'
        #         end
        #       end
        #     end
        #
        #
        # @see http://elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-top-children-query.html
        #
        class TopChildren
          include BaseComponent

          option_method :type
          option_method :score
          option_method :factor
          option_method :incremental_factor
          option_method :_scope

          # DSL method for building the `query` part of the query definition
          #
          # @return [self]
          #
          def query(*args, &block)
            @query = block ? @query = Query.new(*args, &block) : args.first
            self
          end

          # Converts the query definition to a Hash
          #
          # @return [Hash]
          #
          def to_hash
            hash = super
            if @query
              _query = @query.respond_to?(:to_hash) ? @query.to_hash : @query
              hash[self.name].update(query: _query)
            end
            hash
          end
        end

      end
    end
  end
end
