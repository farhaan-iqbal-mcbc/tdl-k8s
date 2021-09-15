call common.bat

for /f %%a in ('C:\Windows\System32\WindowsPowershell\v1.0\powershell -Command "Get-Date -format yyyyMMddHHmmss"') do set "datetime=%%a"
docker build --build-arg python_binary=python3 ../. -t %image_name%
docker tag %image_name% %image_name%:%datetime%