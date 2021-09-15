cd /D "%~dp0"
call common
set registry=%1

docker tag %image_name%:%tag% %registry%/%image_name%:%tag%