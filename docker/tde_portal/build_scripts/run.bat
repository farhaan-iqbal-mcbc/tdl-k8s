cd /D "%~dp0"
call common

REM Add route entry to windows in order to reach container by IP from host
REM route /P add 172.19.0.0 MASK 255.255.0.0 10.0.75.2
docker network create tde-net --subnet=172.19.0.0/16
docker run -d -e MYSQL_HOST=mysql -e MYSQL_PORT=3306 -e MYSQL_USER=root -e MYSQL_PWD=123456 ^
  -e DNS_NAME=tde.someco.net -p 443:443 -p 80:80 -p 8005:8005 -p 8009:8009 --network tde-net --name=tde %image_name%:%tag%
