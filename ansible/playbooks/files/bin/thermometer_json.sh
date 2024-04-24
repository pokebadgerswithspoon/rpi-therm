#!/bin/sh
die() {
  printf "{ error: \"%s\"}" "$1"
  exit 1
}

[ -x "$(command -v dirname)" ] || die "dirname is not present"

THERMOMETER_DIR=$(find "/sys/bus/w1/devices" -name "28-*" -print 2>/dev/null | head -n 1) 
THERMOMETER_FILE="${THERMOMETER_DIR}/w1_slave"
[ -d "${THERMOMETER_DIR}" ] || die "Thermometer device not found"
[ -f "${THERMOMETER_FILE}" ] || die "Thermometer file not found"

TEMPERATURE=$(< "$THERMOMETER_FILE" grep -Po '(?<=t=)([0-9]+)')
if [ "${TEMPERATURE}x" = "x" ]; then
    die "Temperature is unreadable"
fi
printf "{ t: %s }" "$TEMPERATURE"
