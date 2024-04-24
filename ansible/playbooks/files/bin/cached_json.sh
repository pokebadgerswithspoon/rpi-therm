#!/bin/sh
[ -x "$(command -v dirname)" ] || die "dirname is not present"
BIN_DIR=$(dirname "$0")
CACHE_NAME=therm_json CACHE_TTL=1 "${BIN_DIR}/cached.sh" "${BIN_DIR}/thermometer_json.sh"