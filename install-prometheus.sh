#!/bin/bash

oc cluster up 
oc login -u system:admin

# give the developer user cluster-admin so we can import images
oc adm policy add-cluster-role-to-user cluster-admin developer
oc login -u developer

# expose the internal docker registry so we can push to it.
oc create route edge --service=docker-registry -n default

oc project default
oc adm policy add-scc-to-user privileged -ndefault -z prometheus-operator
oc adm policy add-scc-to-user privileged -ndefault -z prometheus

oc apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/bundle.yaml

