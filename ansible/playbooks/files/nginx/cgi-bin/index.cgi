#!/bin/sh
## Entry point for nginx
echo "Content-type: application/json"
echo ""
/opt/therm/bin/cached_json.sh
