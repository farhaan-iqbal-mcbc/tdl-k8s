pushd docker
./build.sh
popd

pushd helm/tde_chart
helm install tde . --set masternode=$hostname --set storage.azure.storageLocation="somelocation" -f values.yaml -f values.admin-bootstrap.sample.yaml -f values.local.overrides.test.yaml -f values.addon.linux-on-prem.yaml --set clusterSizing.atlas=0
popd

