pushd docker
call build.bat %1
popd

pushd helm\tde_chart
helm install tde . -f values.yaml -f values.admin-bootstrap.sample.yaml -f values.local.overrides.test.yaml --set clusterSizing.atlas=0
popd