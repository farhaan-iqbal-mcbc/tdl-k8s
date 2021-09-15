#!/bin/sh

source ./common.sh
docker build ../. -t $image_name
docker tag $image_name $image_name:$(date "+%Y%m%d%H%M%S")