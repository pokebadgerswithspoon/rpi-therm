#!/bin/sh

die() {
  printf "ERROR: %s" "$1"
  exit 1
}

[ -x "$(command -v openssl)" ] || die "openssl is not present"
[ -x "$(command -v date)" ] || die "date command is not present"
[ -x "$(command -v dirname)" ] || die "dirname is not present"
[ -x "$(command -v base64)" ] || die "base64 is not present"
[ -x "$(command -v tr)" ] || die "tr is not present"

BIN_DIR=$(dirname "$0")
JWT_KEY=${JWT_KEY:-"${BIN_DIR}/../conf/jwt.pem"}
JWT_SUB=${JWT_SUB:-"Thermometer jwt"}
encode() 
{
    printf "%s" "$1" | tr -d '\n' | base64 -w 0 | tr -d '=' | tr '/+' '_-' | tr -d '\n'
}
sign()
{
   printf "%s" "$1" | (openssl dgst -sha256 -binary -sign "${JWT_KEY}" || die "Sign error")
}

[ -f "${JWT_KEY}" ] || die "JWT key not found (${JWT_KEY})"

# header=$(jq -c -r . << EOF
#   "{\"alg\": \"RS256\", \"typ\": \"JWT\"}"
# EOF
# )
header="{\"alg\": \"RS256\", \"typ\": \"JWT\"}"
EXP=$(date +%s -d +1hour)
IAT=$(date +%s)
NBF=$(date +%s -d -1second)
payload=$(printf "{\"exp\": %s, \"iat\": %s, \"nbf\": %s, \"sub\": \"%s\"}" "$EXP" "$IAT" "$NBF" "$JWT_SUB")

header=$(encode "$header")
payload=$(encode "$payload")

signature=$(sign "${header}.${payload}")
signature=$(encode "$signature"  | tr -d '==')
printf "%s.%s.%s" "${header}" "${payload}" "${signature}"