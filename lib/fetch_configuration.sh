#!/bin/bash

export PATH=/usr/bin:/bin:"$PATH"
export LC_ALL=UTF-8

ERROR_noAppKeyProvided=(2 "Please specify the app key (use the -k switch)")
ERROR_noApiVersionProvided=(2 "Please specify the api version (use the -v switch)")
ERROR_illegalOption=(3 "Please use -h for help")

fail() {
  eval local error=('"${'$1'[@]}"')
  echo "${error[1]}" 1>&2
  exit ${error[0]}
}

fetch(){
  local query_params="app_key=${app_key}&api_version=${api_version}"
  local fetch_url="https://$base_url/build/fetch_configuration"
  local curl_command="curl -sf"
  $curl_command "$fetch_url?$query_params"
}

# BIN_DIR="$(cd "$(dirname "$0")" && pwd )"
# BASE_DIR="$(dirname "$BIN_DIR")"
# PROJECT_DIR="${BASE_DIR}/../.."
# rollout_build=`(. "$BIN_DIR"/../lib/versions; echo $build)`

shopt -s nullglob

unset help exit app_key base_url api_version
base_url="app.rollout.io"

while getopts "p:k:v:u:h" option; do
  case $option in
    k)
      app_key=$OPTARG
      ;;
    v)
      api_version=$OPTARG
      ;;
    u)
      base_url=$OPTARG
      ;;
    h)
      help=1
      ;;
    *)
      exit=1
      ;;
  esac
done

[ -z "$help" ] || {
  cat << EOF
Usage:
$0 <options>

  -k <app key>           ROX app key (required)
  -v <api version>       ROX api version (required)
  -h                     this help message
EOF
  exit
}

[ -z "$exit" ] || fail ERROR_illegalOption

[ -n "$app_key" ] || fail ERROR_noAppKeyProvided
[ -n "$api_version" ] || fail ERROR_noApiVersionProvided

fetch

exit_status=$?
exit $exit_status
