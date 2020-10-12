ARG ARCH=
FROM ${ARCH}ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    nano \
    && rm -rf /var/lib/apt/lists/*

