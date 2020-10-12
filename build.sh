#!/bin/bash

# from https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/

# loop over required architectures
# docker build -t vajrang/ubuntu:manifest-amd64 --build-arg ARCH=amd64 .
# docker push vajrang/ubuntu:manifest-amd64

arch=('amd64' 'arm32v7' 'arm64v8')
username='vajrang'
imagename='ubuntu'

manifestargs=''

for a in ${arch[@]}
do
    docker build -t $username/$imagename:manifest-$a --build-arg ARCH=$a/ .
    docker push $username/$imagename:manifest-$a
    manifestargs+=" --amend $username/$imagename:manifest-$a"
done

docker manifest create $username/$imagename:latest$manifestargs
docker manifest push $username/$imagename:latest

# TODO: delete the unneeded manifest-{arch} tags on the registry
# looks like it can only be done via the REST api