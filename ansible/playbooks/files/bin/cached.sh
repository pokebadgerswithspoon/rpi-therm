#!/bin/sh
## Primitive cache for long running scripts
CMD=$*
TMPDIR=${TMPDIR:-"/tmp"}
CACHE_NAME=${CACHE_NAME:-cached}
CACHE_FILE="${TMPDIR}/${CACHE_NAME}"
CACHE_TTL=${CACHE_TTL:-1}

out() {
  MSG=$*
  printf "%s" "$MSG" > "$CACHE_FILE"
  printf "%s" "$MSG"
}

if [ -f "$CACHE_FILE" ]; then
   CACHE_AGE=$(($(date +%s) - $( stat -c "%Y" "${CACHE_FILE}")))
   if [ "$CACHE_AGE" -le "${CACHE_TTL}" ]; then
      cat "${CACHE_FILE}"
      exit
   fi
fi

out "$(sh -c "${CMD}")"