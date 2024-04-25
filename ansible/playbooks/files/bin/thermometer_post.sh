#!/bin/sh
die() {
  printf "ERROR: %s" "$1"
  exit 1
}

[ -x "$(command -v curl)" ] || die "curl is not present"

BIN_DIR=$(dirname "$0")

JWT=${JWT:-$("${BIN_DIR}/cached_jwt.sh")}
URL=${URL:-"https://raimond.icantfeelmylegs.com/thermometer"}
JSON=$("${BIN_DIR}/cached_json.sh")

CMD="curl -X POST \
 -d '${JSON}' \
 -H \"Authorization: Bearer ${JWT}\" \
 ${URL}"
sh -c "${CMD}"
