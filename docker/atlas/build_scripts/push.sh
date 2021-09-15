#!/bin/bash

cd "$(dirname "$0")"
source common.sh

registry=$1

sudo docker push $registry/$image_name:$tag
