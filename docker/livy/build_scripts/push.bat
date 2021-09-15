cd /D "%~dp0"
call common
set registry=%1

docker push %registry%/%image_name%:%tag%