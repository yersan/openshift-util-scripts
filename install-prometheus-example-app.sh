#!/bin/bash
BASEURL=https://raw.githubusercontent.com/coreos/prometheus-operator/master/
oc login -u developer
oc project default

for i in example/user-guides/getting-started/example-app-deployment.yaml \
  example/user-guides/getting-started/example-app-service.yaml \
  example/user-guides/getting-started/example-app-service-monitor.yaml \
  example/rbac/prometheus/prometheus-service-account.yaml \
  example/rbac/prometheus/prometheus-cluster-role.yaml \
  example/rbac/prometheus/prometheus-cluster-role-binding.yaml \
  example/user-guides/getting-started/prometheus.yaml \
  example/user-guides/getting-started/prometheus-service.yaml 
do
  echo ${i}
  oc replace --force -f ${BASEURL}/$i
done


