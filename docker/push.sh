#!/bin/bash -e

registry=$1

pushd tde_portal/build_scripts
source tag.sh $registry
source push.sh $registry
popd

pushd spark/build_scripts
source tag.sh $registry
source push.sh $registry
popd

pushd mysql/build_scripts
source tag.sh $registry
source push.sh $registry
popd

pushd atlas/build_scripts
source tag.sh $registry
source push.sh $registry
popd