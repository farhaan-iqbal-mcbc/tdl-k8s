cd /D "%~dp0"
call common

REM Add route entry to windows in order to reach container by IP from host
REM route /P add 172.19.0.0 MASK 255.255.0.0 10.0.75.2
docker network create tde-net --subnet=172.19.0.0/16
docker run -d -p 3000:3000 ^
  --network tde-net --name=grafana %image_name%:%tag%
