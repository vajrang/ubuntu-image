#!/bin/bash

# from https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/

# loop over required architectures
# docker build -t vajrang/ubuntu:manifest-amd64 --build-arg ARCH=amd64 .
# docker push vajrang/ubuntu:manifest-amd64

ARCH='amd64 arm32v7 arm64v8'
USERNAME='vajrang'
IMAGENAME='ubuntu'

MANIFESTARGS=''

for A in $ARCH
do
    docker build -t $USERNAME/$IMAGENAME:manifest-$A --build-arg ARCH=$A/ .
    docker push $USERNAME/$IMAGENAME:manifest-$A
    MANIFESTARGS+=" --amend $USERNAME/$IMAGENAME:manifest-$A"
done

docker manifest create $USERNAME/$IMAGENAME:latest$MANIFESTARGS
docker manifest push $USERNAME/$IMAGENAME:latest

# TODO: delete the unneeded manifest-{arch} tags on the registry
# looks like it can only be done via the REST api