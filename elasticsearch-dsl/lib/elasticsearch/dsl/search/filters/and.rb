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
      module Filters

        # A compound filter which matches documents by an intersection of individual filters.
        #
        # @note Since `and` is a keyword in Ruby, use the `_and` method in DSL definitions
        #
        # @example Pass the filters as a Hash
        #     search do
        #       query do
        #         filtered do
        #           filter do
        #             _and filters: [ {term: { color: 'red' }}, {term: { size:  'xxl' }} ]
        #           end
        #         end
        #       end
        #     end
        #
        # @example Define the filters with a block
        #
        #     search do
        #       query do
        #         filtered do
        #           filter do
        #             _and do
        #               term color: 'red'
        #               term size:  'xxl'
        #             end
        #           end
        #         end
        #       end
        #     end
        #
        # @see http://elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-and-filter.html
        #
        class And
          include BaseComponent
          include BaseCompoundFilterComponent
        end
      end
    end
  end
end
