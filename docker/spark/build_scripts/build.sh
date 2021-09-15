#!/bin/bash

source common.sh
sudo docker build ../. -t $image_name
sudo docker tag $image_name $image_name:$(date "+%Y%m%d%H%M%S")
