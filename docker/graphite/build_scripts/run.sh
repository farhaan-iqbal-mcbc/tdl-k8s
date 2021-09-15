#!/bin/bash

cd "$(dirname "$0")"
source common.sh

sudo docker network create tde-net --subnet=172.19.0.0/16
sudo docker run -d -p 80:80 -p 2003-2004:2003-2004 -p 2023-2024:2023-2024 -p 8125:8125 -p 8126:8126 ^
  --network tde-net --name=graphite %image_name%:%tag%

