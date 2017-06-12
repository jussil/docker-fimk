#!/bin/bash

apiServerPort_var="${SERVER_PROPERTY_PREFIX}apiServerPort"

if [ -z "${1}" ]; then
  echo "First arg needs to be secret phrase"
  exit 1
fi

url="http://localhost:${!apiServerPort_var:-7886}/nxt?requestType=startForging&secretPhrase=${1// /%20}"
if curl -X POST "${url}" -s | grep -q deadline ; then
  echo "Forging started"
  exit 0
fi
echo "Forging failed"
exit 1