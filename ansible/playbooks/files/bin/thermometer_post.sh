#!/bin/sh

BIN_DIR=$(dirname "$0")

die() {
  printf "ERROR: %s" "$1"
  exit 1
}
[ -x "$(command -v curl)" ] || die "curl is not present"

JWT=${JWT:-$("${BIN_DIR}/thermometer_jwt.sh")}
URL=${URL:-"https://raimond.icantfeelmylegs.com/thermometer/post"}
JSON=$("${BIN_DIR}/thermometer_json.sh")

echo curl -X POST \
 -d \'"${JSON}"\' \
 -H 'Accept: application/json' \
 -H "Authorization: Bearer ${JWT}" \
 "${URL}"
