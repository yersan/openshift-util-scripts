#!/bin/bash

# script to import templates into openshift
# change the NAMESPACE parameter to be your project name on OSO

NAMESPACE=openshift

# EAP 7.1
oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/eap/eap71-image-stream.json
for resource in eap71-amq-persistent-s2i.json \
  eap71-amq-s2i.json \
  eap71-basic-s2i.json \
  eap71-https-s2i.json \
  eap71-image-stream.json \
  eap71-mongodb-persistent-s2i.json \
  eap71-mongodb-s2i.json \
  eap71-mysql-persistent-s2i.json \
  eap71-mysql-s2i.json \
  eap71-postgresql-persistent-s2i.json \
  eap71-postgresql-s2i.json \
  eap71-sso-s2i.json \
  eap71-third-party-db-s2i.json \
  eap71-tx-recovery-s2i.json
do
  oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/eap/$resource
done

# AMQ 6.3
for resource in amq/amq63-image-stream.json
do
  oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/$resource
done

for resource in amq63-basic.json \
 amq63-persistent-ssl.json \
 amq63-persistent.json \
 amq63-ssl.json 
do
  oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/amq/$resource
done

# AMQ 7.1
oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/amq-broker-71/amq-broker-7-image-streams.yaml
for resource in amq-broker-71-basic.yaml \
 amq-broker-71-configmap.yaml
do
  oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/amq71-dev/templates/$resource
done

