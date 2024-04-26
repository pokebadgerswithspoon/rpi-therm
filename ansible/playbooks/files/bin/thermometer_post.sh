#!/bin/sh
die() {
  printf "ERROR: %s" "$1"
  exit 1
}

[ -x "$(command -v curl)" ] || die "curl is not present"

BIN_DIR=$(dirname "$0")

JWT=${JWT:-$("${BIN_DIR}/cached_jwt.sh")}
APP_HOST=${APP_HOST:-"https://thermometer-app"}
JSON=$("${BIN_DIR}/cached_json.sh")
MYIP=$(hostname -I)

URL="${APP_HOST}/thermometer"
CMD="curl -X POST \
 -d '${JSON}' \
 -H \"X-MYIP: ${MYIP}\" \
 -H \"Authorization: Bearer ${JWT}\" \
 ${URL}"
sh -c "${CMD}"
