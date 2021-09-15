ARG SPARK_BASE=temenos/data/spark-k8s-3.0.1-3.2.0
FROM ubuntu:18.04 as build

ENV LIVY_VERSION=0.8.0
ENV LIVY_VERSION_STRING=apache-livy-${LIVY_VERSION}-incubating-SNAPSHOT-bin

#ADD http://ftp.jaist.ac.jp/pub/apache/incubator/livy/${LIVY_VERSION}-incubating/${LIVY_VERSION_STRING}.zip .
COPY resources/${LIVY_VERSION_STRING}.zip .

###Final Container
FROM $SPARK_BASE
ENV BASE_IMAGE  $SPARK_BASE#$BASE_IMAGE

ENV LIVY_VERSION=0.8.0
ENV LIVY_VERSION_STRING=apache-livy-${LIVY_VERSION}-incubating-SNAPSHOT-bin
ENV LIVY_HOME=/opt/livy
ENV LIVY_CONF_DIR=$LIVY_HOME/conf

RUN apk add openjdk8 unzip procps
RUN export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")

ENV PATH=/opt/spark/bin:$JAVA_HOME/bin:$PATH:$LIVY_HOME/bin
COPY --from=build ${LIVY_VERSION_STRING}.zip /opt/

WORKDIR /opt

RUN unzip ${LIVY_VERSION_STRING}.zip \
	&& mv ${LIVY_VERSION_STRING} ${LIVY_HOME} \
	&& mkdir ${LIVY_HOME}/logs \
	&& mkdir ${LIVY_CONF_DIR}/conf \
	&& rm ${LIVY_VERSION_STRING}.zip 
	
COPY Dockerfile /my_docker/
	
EXPOSE 4040 7078 7079 8088 10000
