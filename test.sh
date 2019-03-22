#!/usr/bin/env bash
#
# Run a test build for a given image.
# 
# Sample usage:
# 
# $ ./test.sh <image tag> <image version>
#

set -euo pipefail

COLOR_RESET="\e[00m"
COLOR_GREEN="\e[1;32m"
COLOR_RED="\e[00;31m"
FAIL_ICON="\xE2\x9D\x8C"
PASS_ICON="\xE2\x9C\x93"

info() {
  printf "%s\\n" "$@"
}

pass() {
  printf "$COLOR_GREEN$PASS_ICON$COLOR_RESET %s\\n" "$@"
}

fail() {
  printf "$COLOR_RED$FAIL_ICON$COLOR_RESET %s\\n" "$@"; exit 1
}

tag=${1}
version=${2-latest}

testDefaultEntrypoint() {

    local defaultEntrypoint
    local entrypoint

    defaultEntrypoint="[\"pact-broker\"]"
    entrypoint=$(echo `docker inspect --format='{{json .Config.Entrypoint}}' ${tag}:${version}`)
    
    if [[ "$entrypoint" != "$defaultEntrypoint" ]]; then
        fail "Default ENTRYPOINT is not $defaultEntrypoint. Default CMD found: $entrypoint"
    else
        pass "Default ENTRYPOINT is $defaultEntrypoint"
    fi
}

testVersion() {

    local cli_version
    local result

    cli_version="1.18.0"
    result=$(echo `docker run ${tag}:${version} version`)
    
    if [[ "$result" != "$cli_version" ]]; then
        fail "Command version is not $cli_version. Version found: $result"
    else
        pass "Command version is $cli_version"
    fi
}


info "Testing image ${tag}:${version}"

testDefaultEntrypoint
testVersion