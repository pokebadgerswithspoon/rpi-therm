#!/bin/sh

die() {
  printf "ERROR: %s" "$1"
  exit 1
}
[ -x "$(command -v curl)" ] || die "curl is not present"

JWT=${JWT:-$(./thermometer_jwt.sh)}
URL=${URL:-"https://raimond.icantfeelmylegs.com/thermometer/post"}
JSON=$(./thermometer_json.sh)

curl -X POST \
 -d "${JSON}" \
 -H 'Accept: application/json' \
 -H "Authorization: Bearer ${JWT}" \
 "${URL}"
