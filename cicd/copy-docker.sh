#!/usr/bin/env bash
# Copy from one registry to another

SRC="gcr.io/engineering-devops"
#DEST="gcr.io/forgerock-io"
DEST="willdu-forgerock.jfrog.io"
DEST_USERNAME="admin"
DEST_APIKEY="AKCp5dKiN2xr9LqXHea7AXFK5WvznfZ1Np3ZrR489To4Y5j1bf3xbww3f9p2jMguHzCxEwK9E"

TAG="6.5.1"

if [ -n "$1" ];
    then TAG=$1
fi

IMAGES="openam ds openidm openig amster util git java"

for image in $IMAGES; do 
    docker pull $SRC/$image:$TAG 
    docker tag $SRC/$image:$TAG $DEST/$image:$TAG 
    docker login -u $DEST_USERNAME -p $DEST_APIKEY $DEST
    docker push $DEST/$image:$TAG 
done
