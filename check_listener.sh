#!/bin/bash

# Process details
PROCESS_PATH="/opt/m4calc/bin/listener"
PROCESS_OWNER="m4calc"

# Dynatrace environment
DT_ENV="https://dxcdynatrace-activegate.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
API_TOKEN="dt0c01.XXXXXXXXXXXXXXXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

# Check if process is running
if ps -ef | grep "$PROCESS_PATH" | grep "$PROCESS_OWNER" | grep -v grep > /dev/null
then
    STATUS=1   # running
else
    STATUS=0   # not running
fi
HOSTNAME=$(uname -n)
# Push metric to Dynatrace
curl -s -X POST \
  "$DT_ENV/api/v2/metrics/ingest" \
  -H "Authorization: Api-Token $API_TOKEN" \
  -H "Content-Type: text/plain; charset=utf-8" \
  --data-raw "custom.process.listener.running,process=listener,host=$HOSTNAME $STATUS"