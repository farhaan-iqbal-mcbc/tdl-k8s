ARG BASEIMAGE=alpine:3.12.0
FROM $BASEIMAGE as base

RUN true \
 && apk add --update --no-cache \
      cairo \
      cairo-dev \
      collectd \
      collectd-disk \
      collectd-nginx \
      findutils \
      librrd \
      logrotate \
      memcached \
      nginx \
      nodejs \
      npm \
      redis \
      runit \
      sqlite \
      expect \
      dcron \
      python3-dev \
      mysql-client \
      mysql-dev \
      postgresql-client \
      postgresql-dev \
      librdkafka \
      jansson \
 && rm -rf \
      /etc/nginx/conf.d/default.conf \
 && mkdir -p \
      /var/log/carbon \
      /var/log/graphite

FROM base as build


ARG python_binary

RUN true \
 && apk add --update \
      alpine-sdk \
      git \
      pkgconfig \
      wget \
      go \
      cairo-dev \
      libffi-dev \
      openldap-dev \
      python3-dev \
      rrdtool-dev \
      jansson-dev \
      librdkafka-dev \
      mysql-dev \
      postgresql-dev \
 && curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
 && $python_binary /tmp/get-pip.py && rm /tmp/get-pip.py \
 && pip install virtualenv==16.7.10 \
 && virtualenv -p $python_binary /opt/graphite \
 && . /opt/graphite/bin/activate \
 && pip install \
      cairocffi==1.1.0 \
      django==2.2.13 \
      django-statsd-mozilla \
      fadvise \
      gunicorn==20.0.4 \
      eventlet>=0.24.1 \
      gevent>=1.4 \
      msgpack==0.6.2 \
      redis \
      rrdtool \
      python-ldap \
      mysqlclient \
      psycopg2 \
      django-cockroachdb==2.2.*


RUN git clone -b 1.1.7 --depth 1 https://github.com/graphite-project/carbon.git /usr/local/src/carbon 
RUN git clone -b 1.1.7 --depth 1 https://github.com/graphite-project/whisper.git /usr/local/src/whisper 
RUN git clone -b 1.1.7 --depth 1 https://github.com/graphite-project/graphite-web.git /usr/local/src/graphite-web 

RUN cd /usr/local/src/whisper \
 && . /opt/graphite/bin/activate \
 && $python_binary ./setup.py install

RUN . /opt/graphite/bin/activate \
 && cd /usr/local/src/carbon \
 && sed -i "s/git\:/https\:/g" requirements.txt \
 && pip3 install -r requirements.txt \
 && $python_binary ./setup.py install
 
RUN . /opt/graphite/bin/activate \
 && cd /usr/local/src/graphite-web \
 && sed -i "s/git\:/https\:/g" requirements.txt \
 && pip3 install -r requirements.txt \
 && $python_binary ./setup.py install

# install statsd
ARG statsd_version=0.8.6
ARG statsd_repo=https://github.com/statsd/statsd.git
WORKDIR /opt
RUN git clone "${statsd_repo}" \
 && cd /opt/statsd \
 && git checkout tags/v"${statsd_version}" \
 && npm install
 
COPY resources/conf/opt/graphite/conf/                             /opt/defaultconf/graphite/
COPY resources/conf/opt/graphite/webapp/graphite/local_settings.py /opt/defaultconf/graphite/local_settings.py

COPY resources/conf/opt/graphite/conf/* /opt/graphite/conf/
COPY resources/conf/opt/graphite/webapp/graphite/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
WORKDIR /opt/graphite/webapp
RUN mkdir -p /var/log/graphite/ \
  && PYTHONPATH=/opt/graphite/webapp /opt/graphite/bin/django-admin.py collectstatic --noinput --settings=graphite.settings

# config statsd
COPY resources/conf/opt/statsd/config/ /opt/defaultconf/statsd/config/

FROM base as production

ENV STATSD_INTERFACE udp

COPY resources/conf /

# copy from build image
COPY --from=build /opt /opt

# defaults
EXPOSE 80 2003-2004 2013-2014 2023-2024 8080 8125 8125/udp 8126
VOLUME ["/opt/graphite/conf", "/opt/graphite/storage", "/opt/graphite/webapp/graphite/functions/custom", "/etc/nginx", "/opt/statsd/config", "/etc/logrotate.d", "/var/log", "/var/lib/redis"]

STOPSIGNAL SIGHUP

RUN chmod 755 /entrypoint
ENTRYPOINT ["/entrypoint"]