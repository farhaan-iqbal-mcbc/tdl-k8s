cd /D "%~dp0"
call common

set tag=%tag%
set image_name=%image_name%
docker-compose up -d --scale spark-worker=2
