

#!/bin/bash -xe
#cd /u01/app

# Create the database
#echo "ALTER USER ${TEMN_TAFJ_JDBC_USERNAME} ADMIN true;" > alterUser.sql
#java -cp /u01/app/h2.jar org.h2.tools.RunScript -url ${TEMN_TAFJ_JDBC_URL} -user ${TEMN_TAFJ_JDBC_USERNAME} -password ${TEMN_TAFJ_JDBC_PASSWORD} -script ./alterUser.sql -showResults

# Start the H2 server in background
#nohup java ${JAVA_OPTIONS} -server -cp /u01/app/h2.jar:/u01/app/TAFJFunctions.jar org.h2.tools.Server -tcp -tcpPort 3456 -tcpAllowOthers -baseDir /u01/app/h2/data &

# Populate database
java -Dhostname=$LOCAL_HOSTNAME -jar config-installer.jar run-sql-t24db /app/config-files/install-h2-t24base.sql
java -Dhostname=$LOCAL_HOSTNAME -jar config-installer.jar run-sql-t24db /app/config-files/install-h2.sql
java -Dhostname=$LOCAL_HOSTNAME -jar config-installer.jar run-sql-t24db /app/config-files/install-h2-multi-company.sql

# Install DES configuration
echo "------------------------------------------ Installing DES config ------------------------------------------------------------"
java -Dhostname=$LOCAL_HOSTNAME $DES_TOOL_JAVA_OPTIONS -jar /app/config-installer.jar stage-des-config /app/config-files/config.properties $DES_STREAM_VENDOR
java -Dhostname=$LOCAL_HOSTNAME $DES_TOOL_JAVA_OPTIONS -jar /app/config-installer.jar stage-des-config /app/config-files/config.ilp.properties ${DES_STREAM_VENDOR}-ilp

# Populate StreamDB
java -Dhostname=$LOCAL_HOSTNAME -jar config-installer.jar run-sql-streamdb /app/config-files/install-h2-streamdb.sql

# Install Avro schemas
java -Dhostname=$LOCAL_HOSTNAME -jar config-installer.jar stage-schemas /app/schemas 0



# Wait
#sleep infinity