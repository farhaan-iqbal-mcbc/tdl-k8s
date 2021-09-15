#!/bin/bash -e

echo "------------------------------------------ Installing DES config ------------------------------------------------------------"
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS -jar /app/config-installer.jar stage-des-config /app/config-files/config.properties $DES_STREAM_VENDOR
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS -jar /app/config-installer.jar stage-des-config /app/config-files/config.ilp.properties ${DES_STREAM_VENDOR}-ilp

echo "------------------------------------------ Trigger install refresh  ------------------------------------------------------------"
unset http_proxy
curl -X POST -u ${DES_API_SECURITY_USER}:admin http://des-config-app.des:18990/des-install
