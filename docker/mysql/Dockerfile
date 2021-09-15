FROM mysql:8.0.22
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

# requires two env variables to be supplied:
# -e MYSQL_ROOT_HOST=% 
# which allows remote connections as root (to-do use least priviledge principles)
# -e MYSQL_ROOT_PASSWORD=123456
# which sets the root password
RUN apt -y install tzdata

COPY resources/my.cnf /etc/mysql/my.cnf
RUN mkdir /etc/mysql/mysql.conf.d
RUN mkdir /var/lib/mysql-files
RUN chmod 644 /etc/mysql/my.cnf
RUN chmod 644 /etc/mysql/mysql.conf.d
RUN chmod 644 /var/lib/mysql-files
COPY resources/mysqld.service /usr/lib/systemd/system/