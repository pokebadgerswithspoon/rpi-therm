#!/bin/sh
DEV_DIR=${DEV_DIR:-/sys/bus/w1/devices}
die() {
  printf "{ error: \"%s\"}" "$1"
  exit 1
}

[ -x "$(command -v dirname)" ] || die "dirname is not present"

THERMOMETER_DIR=$(find ${DEV_DIR} -type d -name "28-*" -print 2>/dev/null | head -n 1) 
THERMOMETER_FILE="${THERMOMETER_DIR}/w1-slave"
[ -d "${THERMOMETER_DIR}" ] || die "Thermometer device not found"
[ -f "${THERMOMETER_FILE}" ] || die "Thermometer file not found"

TEMPERATURE=$(< "$THERMOMETER_FILE" grep -Po '(?<=t=)([0-9]+)')
if [ "${TEMPERATURE}x" = "x" ]; then
    die "Temperature is unreadable"
fi
printf "{ t: %s }" "$TEMPERATURE"
