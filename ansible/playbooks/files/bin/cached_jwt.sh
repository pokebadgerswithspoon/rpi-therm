#!/bin/sh
[ -x "$(command -v dirname)" ] || die "dirname is not present"
BIN_DIR=$(dirname "$0")
CACHE_NAME=therm_jwt CACHE_TTL=120 "${BIN_DIR}/cached.sh" "${BIN_DIR}/thermometer_jwt.sh"