cd /D "%~dp0"
call common

docker network create tde-net --subnet=172.19.0.0/16

rem // relative path to abs begins
set REL_PATH_TO_COMMON=..\..\..\common\
set ABS_PATH_TO_COMMON=
rem // Save current directory and change to target directory
pushd %REL_PATH_TO_COMMON%
rem // Save value of CD variable (current directory)
set ABS_PATH_TO_COMMON=%CD%

popd
docker-compose run --name=livy %image_name%:%tag%
