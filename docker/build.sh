#!/bin/bash -e

pushd tde_portal/build_scripts
source build.sh
popd

pushd spark/build_scripts
source build.sh
popd

pushd mysql/build_scripts
source build.sh
popd

pushd livy-spark/build_scripts
source build.sh %1
popd

pushd livy/build_scripts
source build.sh %1
popd

pushd grafana/build_scripts
source build.sh %1
popd

pushd graphite/build_scripts
source build.sh %1
popd

pushd atlas/build_scripts
source build.sh
popd
