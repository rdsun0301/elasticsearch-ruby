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

require 'test_helper'

module Elasticsearch
  module Test
    class XPackWatcherQueryWatchesTest < Minitest::Test
      context "XPack Watcher: Query Watches" do
        subject { FakeClient.new }

        should "perform correct request with body" do
          subject.expects(:perform_request).with do |method, url, params, body|
            assert_equal 'POST', method
            assert_equal '_watcher/_query/watches', url
            assert_equal({}, params)
            assert_equal({}, body)
            true
          end.returns(FakeResponse.new)

          subject.xpack.watcher.query_watches(body: {})
        end

        should "perform correct request without body" do
          subject.expects(:perform_request).with do |method, url, params, body|
            assert_equal 'GET', method
            assert_equal '_watcher/_query/watches', url
            assert_equal({}, params)
            assert_nil body
            true
          end.returns(FakeResponse.new)

          subject.xpack.watcher.query_watches
        end
      end
    end
  end
end
