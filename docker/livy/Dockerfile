ARG SPARK_BASE=temenos/data/livy-spark-0.8
FROM $SPARK_BASE

ENV LIVY_HOME=/opt/livy
ENV LIVY_CONF_DIR=$LIVY_HOME/conf

# configure spark
ENV SPARK_HOME /opt/spark
ENV SPARK_CONF_DIR $SPARK_HOME/conf

RUN export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
RUN export PATH=/opt/spark/bin:$PATH

RUN cp $LIVY_CONF_DIR/log4j.properties.template $LIVY_CONF_DIR/log4j.properties && \
    mkdir -p $LIVY_HOME/work-dir && \
    mkdir /var/log/livy && \
    ln -s /var/log/livy $LIVY_HOME/logs
	
RUN apk add curl
RUN apk add sed
COPY resources/conf/livy.conf $LIVY_CONF_DIR/
COPY resources/conf/livy-client.conf $LIVY_CONF_DIR/
COPY resources/entrypoint.sh /opt/
COPY resources/conf/spark-defaults.conf /opt/spark/conf
COPY Dockerfile /my_docker/

#  8998 - Livy Server port
EXPOSE 8998 

WORKDIR $LIVY_HOME/work-dir
RUN chmod 777 $LIVY_HOME
RUN chmod -R 755 $SPARK_CONF_DIR
RUN chmod 755 /opt/entrypoint.sh

ENTRYPOINT [ "/opt/entrypoint.sh" ]