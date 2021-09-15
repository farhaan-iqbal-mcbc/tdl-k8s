FROM tdecloudpublic.azurecr.io/temenos/data/atlas-base@sha256:f3c4e479b47a8cb896d1ffd31b776186b3da5e2f9a563e253b75b7cf3dc92732 as atlasbuild
FROM centos:centos7
## Install OpenJDK-8
RUN yum update -y; yum install -y java-1.8.0-openjdk-devel
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk

ENV ATLAS_HOME /opt/atlas
COPY --from=atlasbuild /opt/atlas ${ATLAS_HOME}
WORKDIR $ATLAS_HOME

# The default types used belong to Atlas 1.1, hence overriding here.
RUN rm -rf /opt/atlas/models/*
COPY resources/models models
RUN mkdir -p /data
RUN mkdir -p /data/solr
COPY resources/atlas_start.py $ATLAS_HOME/bin/atlas_start.py
RUN chmod 777 /opt/atlas/bin/atlas_start.py

EXPOSE 21000 9092 9026 9027

ENV PATH=$PATH:$ATLAS_HOME
ENV MANAGE_LOCAL_HBASE=false
ENV MANAGE_LOCAL_SOLR=true
ENV MANAGE_EMBEDDED_CASSANDRA=true
ENV MANAGE_LOCAL_ELASTICSEARCH=false
ENV KAFKA_HOOK_CONSUMER_GROUP=atlas-k8s
ENV KAFKA_HOOK_BOOTSTRAP_SERVER=host.docker.internal:29092
ENV KAFKA_HOOK_ZK=host.docker.internal:32181

RUN groupadd -r atlas && useradd --no-log-init -r -g atlas atlas
RUN chgrp atlas -R $ATLAS_HOME && chmod -R g+rwx $ATLAS_HOME 
RUN chmod -R 777 $ATLAS_HOME/conf
USER atlas

CMD ["/bin/bash", "-c", "$ATLAS_HOME/bin/atlas_start.py; tail -fFn +1 $ATLAS_HOME/logs/application.log"]