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
docker login -u $DEST_USERNAME -p $DEST_APIKEY $DEST

for image in $IMAGES; do
#List and check the image in DEST with specified name and tag
    DEST_IMAGE=`docker images -q $DEST/$image:$TAG`
    echo "DEST_IMAGE: "$DEST_IMAGE
# if not found
    if [ -z $DEST_IMAGE ]
    then
        echo "Image not found"
        docker pull $SRC/$image:$TAG 
        docker tag $SRC/$image:$TAG $DEST/$image:$TAG 
        docker push $DEST/$image:$TAG 
# if found
    else
        echo "Image found"
    fi
done
