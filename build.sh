#!/bin/bash

ACTION=$1
TAG=$2

if [[ $ACTION == "build" ]]; then
    echo 'Do Nothing'
elif [[ $ACTION == "docker-build" ]]; then
    docker build -t $TAG
fi
