#!/usr/bin/env bash
#
# Called by entry point `run-test` use this script to add your repository specific test commands
#
# Once called Elasticsearch is up and running
#
# Its recommended to call `imports.sh` as defined here so that you get access to all variables defined there
#
# Any parameters that test-matrix.yml defines should be declared here with appropiate defaults

script_path=$(dirname $(realpath -s $0))
source $script_path/functions/imports.sh
set -euo pipefail

echo -e "\033[34;1mINFO:\033[0m VERSION: ${STACK_VERSION}\033[0m"
echo -e "\033[34;1mINFO:\033[0m TEST_SUITE: ${TEST_SUITE}\033[0m"
echo -e "\033[34;1mINFO:\033[0m RUNSCRIPTS: ${RUNSCRIPTS}\033[0m"
echo -e "\033[34;1mINFO:\033[0m URL: ${elasticsearch_url}\033[0m"
echo -e "\033[34;1mINFO:\033[0m CONTAINER: ${elasticsearch_container}\033[0m"

#
# Ruby client setup:
#

export RUBY_TEST_VERSION=${RUBY_TEST_VERSION:-2.7.0}
export STACK_VERSION=${STACK_VERSION:-8.0.0-SNAPSHOT}
export SINGLE_TEST=${SINGLE_TEST:-}

echo -e "\033[1m>>>>> Build [elastic/elasticsearch-ruby container] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>\033[0m"
# create client image
docker build \
       --file .ci/Dockerfile \
       --tag elastic/elasticsearch-ruby \
       --build-arg RUBY_TEST_VERSION=${RUBY_TEST_VERSION} \
       .

echo -e "\033[1m>>>>> Run [elastic/elasticsearch-ruby container] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>\033[0m"

repo=`pwd`

# run the client tests
if [[ $STACK_VERSION =~ (^8\.) ]]; then
    echo -e "\033[1m RUNNING COMPATIBILITY MODE \033[0m"
    docker run \
         -u "$(id -u)" \
         --network="${network_name}" \
         --env "ELASTIC_CLIENT_APIVERSIONING=true" \
         --env "ELASTIC_PASSWORD=${elastic_password}" \
         --env "ELASTIC_USER=elastic" \
         --env "QUIET=false" \
         --env "STACK_VERSION=${STACK_VERSION}" \
         --env "TEST_ES_SERVER=${elasticsearch_url}" \
         --env "TEST_SUITE=${TEST_SUITE}" \
         --volume $repo:/usr/src/app \
         --volume=/tmp:/tmp \
         --name elasticsearch-ruby \
         --rm \
         elastic/elasticsearch-ruby \
         bundle exec rake elasticsearch:download_artifacts test:rest_api
else
    if [[ $TEST_SUITE != "platinum" ]]; then
        docker run \
               -u "$(id -u)" \
               --network="${network_name}" \
               --env "TEST_ES_SERVER=${elasticsearch_url}" \
               --env "TEST_SUITE=${TEST_SUITE}" \
               --env "STACK_VERSION=${STACK_VERSION}" \
               --volume $repo:/usr/src/app \
               --volume=/tmp:/tmp \
               --name elasticsearch-ruby \
               --rm \
               elastic/elasticsearch-ruby \
               bundle exec rake elasticsearch:download_artifacts test:rest_api
    else
        docker run \
               -u "$(id -u)" \
               --network="${network_name}" \
               --env "TEST_ES_SERVER=${elasticsearch_url}" \
               --env "ELASTIC_USER=elastic" \
               --env "ELASTIC_PASSWORD=${elastic_password}" \
               --env "TEST_SUITE=${TEST_SUITE}" \
               --env "SINGLE_TEST=${SINGLE_TEST}" \
               --env "STACK_VERSION=${STACK_VERSION}" \
               --volume $repo:/usr/src/app \
               --name elasticsearch-ruby \
               --rm \
               elastic/elasticsearch-ruby \
               bundle exec rake elasticsearch:download_artifacts test:security
    fi
fi
