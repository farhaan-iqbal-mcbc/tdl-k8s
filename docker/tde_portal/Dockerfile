FROM centos:centos7
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


ENV TOMCAT_DIST 8
ENV TOMCAT_VERSION 8.5.61
ENV SPARK_VERSION 3.0.0
ENV SPARK_HADOOP_VERSION hadoop3.2

RUN yum -y install mysql unzip java-1.8.0-openjdk nmap \
  nano wget curl net-tools lsof zip tzdata
RUN export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")


# install tomcat
RUN wget "https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_DIST}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.zip" \
    -O "/tmp/apache-tomcat-${TOMCAT_VERSION}.zip" &&\
    unzip /tmp/apache-tomcat-*.zip -d /tmp &&\
    mkdir -p /opt/tomcat &&\
    mv /tmp/apache-tomcat-${TOMCAT_VERSION}/* /opt/tomcat/

# install spark
ENV SPARK_HOME /opt/spark
RUN mkdir -p /opt && \
    cd /opt && \
    curl "http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-$SPARK_HADOOP_VERSION.tgz" | \
        tar -zx && \
    ln -s /opt/spark-${SPARK_VERSION}-bin-$SPARK_HADOOP_VERSION /opt/spark && \
    echo Spark ${SPARK_VERSION} installed in /opt

# add htrunk
RUN mkdir -p /usr/lib/htrunk/Tomcat \
    /usr/lib/htrunk/work \
    /usr/lib/htrunk/conf \
    /usr/lib/htrunk/lib \
    /usr/lib/htrunk/logs \
    /usr/lib/htrunk/temp
RUN ln -s /opt/tomcat/* /usr/lib/htrunk/Tomcat
COPY resources/tde /usr/lib/htrunk
COPY resources/Tomcat /opt/tomcat
RUN rm -fR /opt/tomcat/webapps/*
RUN chmod +x /opt/tomcat/bin/*.sh
RUN chmod -R 755 /usr/lib/htrunk/ /opt/spark

# add artifacts
COPY resources/artifacts/Admin.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/Deployer.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/Designer.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/ROOT.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/Scheduler.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/TemenosMetaService.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/UtilServices.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/ValidateHiveSQL.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/hTRUNK_Secured_Manager.war /usr/lib/htrunk/Tomcat/webapps
COPY resources/artifacts/des-tdl-landing-process.jar /usr/lib/htrunk/work
COPY resources/artifacts/tde_phoenix.jar /usr/lib/htrunk/work
COPY resources/artifacts/tde_azure.jar /usr/lib/htrunk/work
COPY resources/artifacts/tde-rule-engine.jar /usr/lib/htrunk/work
COPY resources/artifacts/tdl-job-monitor.jar /usr/lib/htrunk/work
COPY resources/artifacts/ads-reprocessor.jar /usr/lib/htrunk/work
COPY resources/artifacts/ads-processor.jar /usr/lib/htrunk/work
COPY resources/artifacts/tde_azure.jar /usr/lib/htrunk/work

# system users
RUN useradd -ms /bin/bash designer && \
  useradd -ms /bin/bash tester && \
  echo tester:demo | chpasswd && \
  echo designer:demo | chpasswd

# create logs dir
RUN mkdir -p /home/designer/htrunk_logs /logs; chmod 757 /home/designer/htrunk_logs /logs

ENV SSL_PORT=443 \
  HTTP_PORT=80 \
  SHUTDOWN_PORT=8005 \
  AJP_PORT=8009

EXPOSE 80 443 8005 8009

# COPY build_scripts/zz_version .

WORKDIR /usr/lib/htrunk



