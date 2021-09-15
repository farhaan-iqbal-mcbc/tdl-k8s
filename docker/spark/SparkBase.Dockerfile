FROM alpine:3.12.0
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

RUN { echo '#!/bin/sh'; echo 'set -e'; echo; echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; } > /usr/local/bin/docker-java-home && \
    chmod +x /usr/local/bin/docker-java-home;

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JAVA_VERSION=8u252
ENV JAVA_ALPINE_VERSION=8.252.09-r0
CMD echo $(docker-java-home)
RUN apk add --no-cache openjdk8="$JAVA_ALPINE_VERSION" && \
    /bin/sh -c set -ex &&  \
    apk upgrade --no-cache && \
    ln -s /lib /lib64 && \
    apk add --no-cache bash tini libc6-compat linux-pam nss && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && \
    chmod ug+rw /etc/passwd && \
    mkdir -p /etc/metrics/conf && \
    mkdir -p /prometheus && \
    wget https://s3-us-west-2.amazonaws.com/fdp-kubernetes-builds/spark/extra/metrics.properties -O /etc/metrics/conf/metrics.properties && \
    wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.11.0/jmx_prometheus_javaagent-0.11.0.jar -O /prometheus/jmx_prometheus_javaagent-0.11.0.jar && \
    wget https://s3-us-west-2.amazonaws.com/fdp-kubernetes-builds/spark/extra/spark-prom-exporter.yml -O /etc/metrics/conf/prometheus.yaml && \
    chgrp -R 0 /prometheus && \
    chmod -R g=u /prometheus && \
    chgrp -R 0 /etc/metrics/conf && \
    chmod -R g=u /etc/metrics/conf

COPY resources/spark-3.0.1-bin-hadoop3.2.tar.gz /
RUN mkdir -p /opt/spark; tar xfv /spark-3.0.1-bin-hadoop3.2.tar.gz -C /opt/spark; rm -f /spark-3.0.1-bin-hadoop3.2.tar.gz
ENV SPARK_HOME=/opt/spark
WORKDIR /opt/spark/work-dir
