#!/bin/sh
cd "$(dirname "$0")"
sed "s/@POD_IP@/$POD_IP/" spark-defaults-template.conf;