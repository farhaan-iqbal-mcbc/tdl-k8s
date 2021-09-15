#!/bin/bash

cd "$(dirname "$0")"
source common.sh

registry=$1

sudo docker tag $image_name:$tag $registry/$image_name:$tag