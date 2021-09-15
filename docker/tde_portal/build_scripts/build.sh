#!/bin/bash
if [[ $@ == 'dev' ]]; then
  TDL_DIST_PATH='../../../../../../../tde'
  rm -fR ../resources/artifacts/*
#  mvn clean install -DskipTests -f $TDL_DIST_PATH/pom.xml
  unzip "$TDL_DIST_PATH/tdl-dist/target/*.zip" -d ../resources/artifacts
else
  unzip ../../../../tdl_setup.zip -d .
  mkdir -p ../resources/artifacts
  mkdir -p ../resources/tde
  mkdir -p ../resources/Tomcat
  mkdir -p ../resources/Tomcat/bin
  mkdir -p ../resources/Tomcat/conf
  mkdir -p ../resources/Tomcat/lib
  cp ../../../../tde_metastore_handler.jar ../resources/Tomcat/lib
  cp ../../../../*.war ../../../../*.jar ../resources/artifacts
  cp common/*.sh ../resources/tde
  cp K8s/*.sh ../resources/tde
  cp Tomcat/bin/*.* ../resources/Tomcat/bin
  cp Tomcat/lib/*.* ../resources/Tomcat/lib
  cp Tomcat/conf/*.* ../resources/Tomcat/conf
fi

source common.sh
docker build ../. -t $image_name
docker tag $image_name $image_name:$(date "+%Y%m%d%H%M%S")
