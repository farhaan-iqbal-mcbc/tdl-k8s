
call common.bat
set _TDL_DIST_PATH=..\..\..\..\..\..\tdl-dist
if "%1" == "dev" (
    del /S /Q ..\resources\artifacts\*.*
    call mvn clean package -f %_TDL_DIST_PATH%\pom.xml
    tar -xf %_TDL_DIST_PATH%\target\Temenos_Data_Engineering-DEV.0.0-SNAPSHOT.zip -C ..\resources\artifacts
) else (
  tar -xf ..\..\..\..\tdl_setup.zip
  mkdir -p ..\resources\artifacts
  mkdir -p ..\resources\tde
  mkdir -p ..\resources\Tomcat
  mkdir -p ..\resources\Tomcat\bin
  mkdir -p ..\resources\Tomcat\conf
  mkdir -p ..\resources\Tomcat\lib
  copy ..\..\..\..\tde_metastore_handler.jar ..\resources\Tomcat\lib
  copy ..\..\..\..\*.war ..\resources\artifacts
  copy ..\..\..\..\*.jar ..\resources\artifacts
  copy common\*.sh ..\resources\tde
  copy K8s\*.sh ..\resources\tde
  copy Tomcat\bin\*.* ..\resources\Tomcat\bin
  copy Tomcat\lib\*.* ..\resources\Tomcat\lib
  copy Tomcat\conf\*.* ..\resources\Tomcat\conf
)
for /f %%a in ('C:\Windows\System32\WindowsPowershell\v1.0\powershell -Command "Get-Date -format yyyyMMddHHmmss"') do set "datetime=%%a"
docker build ../. -t %image_name%
docker tag %image_name% %image_name%:%datetime%
