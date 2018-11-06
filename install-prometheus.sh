#!/bin/bash

BASEURL=https://raw.githubusercontent.com/coreos/prometheus-operator/master/

oc cluster up 
oc login -u system:admin

# give the developer user cluster-admin so we can import images
oc adm policy add-cluster-role-to-user cluster-admin developer
oc login -u developer

# expose the internal docker registry so we can push to it.
oc create route edge --service=docker-registry -n default

oc project default
oc adm policy add-scc-to-user privileged -n default -z prometheus-operator
oc adm policy add-scc-to-user privileged -n default -z prometheus

for i in bundle.yaml \
  example/rbac/prometheus/prometheus-service-account.yaml \
  example/rbac/prometheus/prometheus-cluster-role.yaml \
  example/rbac/prometheus/prometheus-cluster-role-binding.yaml \
  example/user-guides/getting-started/prometheus.yaml \
  example/user-guides/getting-started/prometheus-service.yaml 
do
  echo ${i}
  oc apply -f ${BASEURL}/$i
done

#install the route

oc create route edge -n default --service=prometheus

# prometheus console should now be available at https://prometheus-default.127.0.0.1.nip.io
