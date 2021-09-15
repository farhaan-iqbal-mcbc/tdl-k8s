#!/bin/bash

source common.sh
docker build --build-arg "GRAFANA_VERSION=latest" --build-arg "GF_INSTALL_IMAGE_RENDERER_PLUGIN=false" ../. -t $image_name
docker tag $image_name $image_name:$(date "+%Y%m%d%H%M%S")