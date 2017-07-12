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

shopt -s nullglob

unset help app_key
while getopts "p:k:u:h" option; do
  case $option in
    k)
      app_key=$OPTARG
      ;;
    v)
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
  -v <api version>       ROX api version (required)
  s-h                    x this help message

  This Script downloads the configruation from ROX service and place it in app bundle.
  ROX setup needs to be called with the right options to retrive this file,  here is how it can be done in objective-c:

    ROXOptions *options = [[ROXOptions alloc] init];
    options.defaultConfigurationPath = [[NSBundle mainBundle] pathForResource:APP_KEY ofType:@"json"];
    [ROX setupWithKey:APP_KEY options:options];


EOF
  exit
}

[ -z "$exit" ] || fail ERROR_illegalOption
[ -n "$app_key" ] || fail ERROR_noAppKeyProvided
[ -n "$api_version" ] || fail ERROR_noApiVersionProvided


BIN_DIR="$(cd "$(dirname "$0")" && pwd )"
FETCH_CONFIGURATION="$BIN_DIR/fetch_configuration.sh"
DSTFILE="$app_key.json"
TMPFILE=`mktemp -t $DSTFILE` || exit 1

/bin/sh "$FETCH_CONFIGURATION" -k $app_key -v $api_version > $TMPFILE

cp -v $TMPFILE  "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/$DSTFILE"
if [ -r  "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" ]; then
		echo "Rox defaults: Installation mode, special copy"
		cp -v $TMPFILE  "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/$DSTFILE"
fi

rm -f $TMPFILE
