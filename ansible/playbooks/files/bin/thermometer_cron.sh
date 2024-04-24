#!/bin/sh
## Entrypoint for cronjob
BIN_DIR=$(dirname "$0")
"${BIN_DIR}/thermometer_post.sh"
