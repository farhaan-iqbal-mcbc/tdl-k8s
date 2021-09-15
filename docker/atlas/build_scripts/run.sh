#!/bin/bash

cd "$(dirname "$0")"
source common.sh

sudo docker network create tde-net --subnet=172.19.0.0/16
sudo docker run -d -p 21000:21000 \
  --mount type=bind,source=$PWD/../../../common/config-files/atlas/atlas-application.properties,target=/apache-atlas-2.0.0/conf/atlas-application.properties \
  --network tde-net --name=atlas $image_name:$tag

