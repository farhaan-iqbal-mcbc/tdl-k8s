#!/bin/bash

cd "$(dirname "$0")"
source common.sh

docker network create tde-net --subnet=172.19.0.0/16
docker run -d -p 3306:3306 -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=123456 --network=tde-net \
  --name=mysql $image_name:$tag

