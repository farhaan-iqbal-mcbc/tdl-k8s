ARG ATLAS_MAVEN_PROFILE=dist,embedded-cassandra-solr
ARG ATLAS_COMMIT=11adb7ecfc855ca73ab30a5b24b0fd3ea4ab9197


FROM ubuntu:18.04
ARG ATLAS_COMMIT
ARG ATLAS_MAVEN_PROFILE
RUN apt-get update \
    && apt-get -y install  --no-install-recommends \
        bash python curl iproute2 maven wget git xmlstarlet \
    && rm -rf /var/lib/apt/lists/*
RUN cd /tmp \
    && wget -O apache-atlas-sources.tar.gz \
        https://github.com/apache/atlas/archive/${ATLAS_COMMIT}.tar.gz \
    && mkdir /tmp/atlas-src \
    && tar --strip 1 -xzvf apache-atlas-sources.tar.gz -C /tmp/atlas-src \
    && rm apache-atlas-sources.tar.gz \
    && cd /tmp/atlas-src

RUN cd /tmp/atlas-src \
    && xmlstarlet ed --inplace -N N="http://maven.apache.org/POM/4.0.0" \
                    -u '//N:dependency[N:groupId="org.apache.cassandra"]/N:version' \
                    -v "2.2.13" repository/pom.xml \
    && xmlstarlet ed --inplace -N N="http://maven.apache.org/POM/4.0.0" \
                    -s '//N:dependency[N:artifactId="cassandra-all"]/N:exclusions' \
                    -t elem -n exclusion -v "" \
                    -s '//exclusion' -t elem -n groupId -v "org.slf4j" \
                    -s '//exclusion' -t elem -n artifactId -v 'log4j-over-slf4j' repository/pom.xml \
    && xmlstarlet ed --inplace -N N="http://maven.apache.org/POM/4.0.0" \
                    -s '//N:dependency[N:artifactId="storm-core"]/N:exclusions' \
                    -t elem -n exclusion -v "" \
                    -s '//exclusion' -t elem -n groupId -v "org.slf4j" \
                    -s '//exclusion' -t elem -n artifactId -v 'log4j-over-slf4j' addons/storm-bridge-shim/pom.xml \
    && xmlstarlet ed --inplace -N N="http://maven.apache.org/POM/4.0.0" \
                    -d "//N:descriptor[contains(text(), 'src/main/assemblies/atlas-sqoop-hook-package.xml')]" distro/pom.xml \
    && export MAVEN_OPTS="-Xms2g -Xmx2g" \
    && mvn -pl '!addons/sqoop-bridge-shim,!addons/sqoop-bridge' clean -Dmaven.repo.local=/tmp/.mvn-repo -Dhttps.protocols=TLSv1.2 -DskipTests package -P${ATLAS_MAVEN_PROFILE} \
    && ATLAS_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec) \
    && mkdir -p /opt/atlas \
    && tar -xzvf /tmp/atlas-src/distro/target/apache-atlas-${ATLAS_VERSION}-server.tar.gz -C /opt/atlas --strip-components 1 \
    && echo "${ATLAS_VERSION}-${ATLAS_MAVEN_PROFILE}" > /opt/atlas/version.txt \
    && rm -fR /tmp
