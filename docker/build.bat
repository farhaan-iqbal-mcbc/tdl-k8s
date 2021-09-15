
pushd tde_portal\build_scripts
call build.bat %1
popd

pushd spark\build_scripts
call build.bat %1
popd

pushd mysql\build_scripts
call build.bat %1
popd

pushd livy-spark\build_scripts
call build.bat %1
popd

pushd livy\build_scripts
call build.bat %1
popd

pushd grafana\build_scripts
call build.bat %1
popd

pushd graphite\build_scripts
call build.bat %1
popd

pushd atlas\build_scripts
call build.bat %1
popd