# FIMK Cryptocurrency Server

FIMK Java server container.
http://fimk.fi/en/
https://heatnodes.org/?page_id=244

## Requirements

  - [Install Docker](https://docs.docker.com/engine/installation/)


## Building image

Check docker hub releases for exact image versions: https://hub.docker.com/r/jussil/fimk/

  - Run in the repository dir `docker build -t jussil/fimk .`


## Creating hallmark

In order to participate in lottery you need hallmark. To create it, run the container script `/hallmark.sh "<wallet secret phrase>" <PUBLIC IP/HOST>`, ie:
```
docker run --rm /hallmark.sh "dog cat sheep .." 911.911.911.911
```

This will run the server inside the container and do the API request locally to acquire hallmark.

## Run server

Run the server in detached mode.
```
docker run -d --name fimk \
  -p 7884:7884 \
  -p 7886:7886 \
  -e "nxt__maxNumberOfConnectedPublicPeers=500" \
  -e "nxt__myPlatform=<LOMPSA ACCOUNT ID (numeric)>" \
  -e "nxt__myAddress=<PUBLIC IP/HOST OF SERVER>" \
  -e "nxt__myHallmark=<HALLMARK GENERATED WITH SCRIPT>" \
  jussil/fimk
```

### Forging

In order to start forging after server is in sync, you need to do an API request to your server with your secret phrase.

You can do this by executing script inside of running server container like this (assuming you named your container `fimk`:
```
docker exec fimk /forge.sh "your secret passphrase"
```


## Configuration

All passed environment variables that starts with nxt__ will be used as config. First we transform `__` characters into `.` to match properties config style and then replace provided config values from base properties file.

You should check default configurations from running container under `/opt/fimk/conf/nxt-default.properties`

## Author
Jussi Lindfors