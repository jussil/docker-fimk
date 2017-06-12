#!/bin/bash

apiServerPort_var="${SERVER_PROPERTY_PREFIX}apiServerPort"

if [ -z "${1}" ]; then
  echo "First arg needs to be secret phrase"
  exit 1
fi

if [ -z "${2}" ]; then
  echo "Second arg needs to be public IP/host to the server"
  exit 1
fi

# Start server with default settings
screen -d -m bash -c "cd ${SERVER_ROOT} && ${SERVER_BIN}"
# Wait for API server to start
/wait-for-api.sh
if [ $? -ne 0 ]; then
  echo "No API connection!$?"
  exit 1
fi

# Make hallmark create call and try to parse hallmark out if it
current_date=$(date +"%Y-%m-%d")
output=$(curl -X POST -vs "http://localhost:${!apiServerPort_var:-7886}/nxt?requestType=markHost&secretPhrase=${1// /%20}&host=${2}&weight=100&date=${current_date}" 2>&1)
hallmark=$(echo ${output} | grep -Po '(?<="hallmark":")[^"]*')
if [ -z "${hallmark}" ]; then
  echo "Hallmark not created!"
  exit 1
fi
echo ${hallmark}
