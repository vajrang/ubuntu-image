ARG ARCH=
FROM ${ARCH}ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

LABEL description="multi-arch ubuntu image with all apt upgrades applied + git, curl, nano installed"
