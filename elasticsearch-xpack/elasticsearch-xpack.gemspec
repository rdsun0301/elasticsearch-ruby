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

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elasticsearch/xpack/version'

Gem::Specification.new do |spec|
  spec.name          = 'elasticsearch-xpack'
  spec.version       = Elasticsearch::XPack::VERSION
  spec.authors       = ['Karel Minarik']
  spec.email         = ['karel@elastic.co']

  spec.summary       = 'Ruby integrations for the X-Pack extensions for Elasticsearch'
  spec.description   = 'Ruby integrations for the X-Pack extensions for Elasticsearch'
  spec.homepage      = 'https://www.elastic.co/guide/en/elasticsearch/client/ruby-api/7.16/index.html'
  spec.license       = 'Apache-2.0'
  spec.metadata = {
    'homepage_uri' => 'https://www.elastic.co/guide/en/elasticsearch/client/ruby-api/7.16/index.html',
    'changelog_uri' => 'https://github.com/elastic/elasticsearch-ruby/blob/7.16/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/elastic/elasticsearch-ruby/tree/7.16/elasticsearch-xpack',
    'bug_tracker_uri' => 'https://github.com/elastic/elasticsearch-ruby/issues'
  }
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'ruby-prof' unless defined?(JRUBY_VERSION) || defined?(Rubinius)

  spec.add_dependency 'elasticsearch-api', '>= 6'

  spec.add_development_dependency 'elasticsearch', '>= 6'
  spec.add_development_dependency 'elasticsearch-extensions'
  spec.add_development_dependency 'elasticsearch-transport', '>= 6'

  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'ansi'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'shoulda-context'
  spec.add_development_dependency 'yard'
  spec.post_install_message = <<~MSG
    WARNING: This library is deprecated

    The API endpoints currently living in elasticsearch-xpack will be moved into elasticsearch-api in version 8.0.0 and forward. You should be able to keep using elasticsearch-xpack and the xpack namespace in 7.x. We're running the same tests in elasticsearch-xpack, but if you encounter any problems, please let us know in this issue: https://github.com/elastic/elasticsearch-ruby/issues/1274 \n
  MSG
end
