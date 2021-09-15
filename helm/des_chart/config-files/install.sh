#!/bin/bash -e

echo "------------------------------------------ Populating T24 DB ----------------------------------------------------------------"
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS -Dtemn.des.db.sql.script.statement.separator=$ \
  -jar /app/config-installer.jar run-sql-t24db /app/config-files/install-functions.sql;
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS \
  -jar /app/config-installer.jar run-sql-t24db /app/config-files/install.sql;
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS -Dtemn.des.db.sql.script.statement.separator=$ \
  -jar /app/config-installer.jar run-sql-t24db /app/config-files/install-triggers.sql;

echo "------------------------------------------ Populating Stream DB -------------------------------------------------------------"
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS -jar /app/config-installer.jar run-sql-streamdb /app/config-files/install-stream.sql
echo "------------------------------------------ Installing Schemas ---------------------------------------------------------------"
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS -jar /app/config-installer.jar stage-schemas /app/schemas 0
echo "------------------------------------------ Installing DES config ------------------------------------------------------------"
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS -jar /app/config-installer.jar stage-des-config /app/config-files/config.properties $DES_STREAM_VENDOR
java -Dhostname=$HOSTNAME $DES_TOOL_JAVA_OPTIONS -jar /app/config-installer.jar stage-des-config /app/config-files/config.ilp.properties ${DES_STREAM_VENDOR}-ilp

echo "------------------------------------------ Trigger install refresh  ------------------------------------------------------------"
unset http_proxy
curl -X POST -u ${DES_API_SECURITY_USER}:admin http://des-config-app.des:18990/des-install
