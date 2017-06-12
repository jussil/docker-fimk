#!/bin/bash

apiServerPort_var="${SERVER_PROPERTY_PREFIX}apiServerPort"

# Wait up to 60 seconds for API server to come online
n=0
until [ $n -ge 10 ]
do
  http_code=$(curl -sL -w "%{http_code}\\n" "http://localhost:${!apiServerPort_var:-7886}/nxt?requestType=markHost" -o /dev/null)
  if [ ${http_code} == "200" ] ; then
    exit 0
  fi
  n=$[$n+1]
  sleep 6
done
exit 1
