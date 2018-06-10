#!/bin/bash

export PATH=/usr/bin:/bin:"$PATH"
export LC_ALL=UTF-8

ERROR_noAppKeyProvided=(2 "Please specify the app key (use the -k switch)")
ERROR_noSdkVersionProvided=(2 "Please specify the sdk version (use the -v switch)")
ERROR_noApiVersionProvided=(2 "Please specify the api version (use the -a switch)")
ERROR_noPlatformProvided=(2 "Please specify the platform (use the -t switch)")
ERROR_illegalOption=(3 "Please use -h for help")

fail() {
  eval local error=('"${'$1'[@]}"')
  echo "${error[1]}" 1>&2
  exit ${error[0]}
}

fetch(){
  local query_params="api_version=${api_version}&app_key=${app_key}&sdk_version=${sdk_version}&platform=$platform"
  local fetch_url="https://$base_url/device/embedded_configuration"
  local curl_command="curl -sf"
  $curl_command "$fetch_url?$query_params"
}

shopt -s nullglob

unset help exit app_key base_url sdk_version api_version platform
base_url="x-api.rollout.io"

while getopts "t:a:p:k:v:u:h" option; do
  case $option in
    t)
      platform=$OPTARG
      ;;
    k)
      app_key=$OPTARG
      ;;
    v)
      sdk_version=$OPTARG
      ;;
    u)
      base_url=$OPTARG
      ;;
    a)
      api_version=$OPTARG
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
  -v <sdk version>       ROX sdk version (required)
  -a <api_version>	 ROX api version (required)
  -t <platform>	         ROX platform (required)
  -h                     this help message
EOF
  exit
}

[ -z "$exit" ] || fail ERROR_illegalOption

[ -n "$app_key" ] || fail ERROR_noAppKeyProvided
[ -n "$sdk_version" ] || fail ERROR_noSdkVersionProvided
[ -n "$api_version" ] || fail ERROR_noApiVersionProvided
[ -n "$platform" ] || fail ERROR_noPlatformProvided

fetch

exit_status=$?
exit $exit_status
