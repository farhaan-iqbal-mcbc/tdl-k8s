#!/bin/bash

source common.sh
docker build --build-arg python_binary=python3 ../. -t $image_name
docker tag $image_name $image_name:$(date "+%Y%m%d%H%M%S")
