FROM tdecloudpublic.azurecr.io/temenos/data/spark-k8s-3.0.1-3.2.0-base
LABEL maintainer="Temenos" \
      org.label-schema.schema-version="" \
      org.label-schema.vendor="Temenos" \
      org.label-schema.name="" \
      org.label-schema.version="" \
      org.label-schema.license="" \
      org.label-schema.description="" \
      org.label-schema.url="" \
      org.label-schema.usage="" \
      org.label-schema.build-date="" \
      org.label-schema.vcs-url="" \
      org.label-schema.docker.cmd=""

ADD resources/entrypoint.sh /opt/entrypoint.sh
RUN chmod 755 /opt/entrypoint.sh
ADD resources/log4j.properties /log4j.properties
ADD resources/jars/* /opt/spark/jars/
RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/com/google/code/gson/gson/2.8.6/gson-2.8.6.jar && \
    wget https://repo1.maven.org/maven2/org/apache/avro/avro/1.9.1/avro-1.9.1.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure-datalake/3.1.1/hadoop-azure-datalake-3.1.1.jar && \
    wget https://repo1.maven.org/maven2/com/microsoft/azure/azure-data-lake-store-sdk/2.2.7/azure-data-lake-store-sdk-2.2.7.jar && \
    rm /opt/spark/jars/avro-1.8.2.jar && \
    rm /opt/spark/jars/geronimo-jcache_1.0_spec-1.0-alpha-1.jar && \
    rm /opt/spark/jars/gson-2.2.4.jar
ENTRYPOINT ["/opt/entrypoint.sh"]
