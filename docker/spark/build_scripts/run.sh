#!/bin/bash

cd "$(dirname "$0")"
source common.sh

export tag=$tag
export image_name=$image_name
docker-compose up -d --scale spark-worker=2

