@echo off
cd /D "%~dp0"
call common

REM Add route entry to windows in order to reach container by IP from host
REM route /P add 172.19.0.0 MASK 255.255.0.0 10.0.75.2
docker network create tde-net --subnet=172.19.0.0/16

rem // relative path to abs begins
set REL_PATH_TO_COMMON=..\..\..\common\
set ABS_PATH_TO_COMMON=
rem // Save current directory and change to target directory
pushd %REL_PATH_TO_COMMON%
rem // Save value of CD variable (current directory)
set ABS_PATH_TO_COMMON=%CD%
rem // Restore original directory
popd
rem // relative path to abs ends
docker run -d -p 3306:3306 -e MYSQL_ROOT_HOST=%% -e MYSQL_ROOT_PASSWORD=123456 ^
  --network tde-net --name=mysql %image_name%:%tag%
