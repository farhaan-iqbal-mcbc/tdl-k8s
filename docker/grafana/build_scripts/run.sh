#!/bin/bash

cd "$(dirname "$0")"
source common.sh

sudo docker network create tde-net --subnet=172.19.0.0/16
sudo docker run -d -p 3000:3000 \
  --network=tde-net --name=grafana $image_name:$tag

