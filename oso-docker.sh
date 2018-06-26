#!/bin/bash

TOKEN=`oc whoami -t`
EMAIL="ken@zaptillion.net"
USER="ken@zaptillion.net"
CLUSTER="starter-us-west-1"
SRCIMG=jboss-eap-7-tech-preview/eap-cd-openshift:13.0
TGTIMG=eap-cd-openshift:13.0
REGISTRY=registry.${CLUSTER}.openshift.com
IS_TAG=13

PROJECT=zapmyproject

docker login -u ${USER} -e ${EMAIL} \
    -p ${TOKEN} https://${REGISTRY}

docker tag ${SRCIMG} ${REGISTRY}/${PROJECT}/${TGTIMG}
docker push ${REGISTRY}/${PROJECT}/${TGTIMG}
# add the 13 imagestream tag
oc tag ${TGTIMG} eap-cd-openshift:13

for resource in eap-cd-amq-persistent-s2i.json \
  eap-cd-amq-s2i.json \
  eap-cd-basic-s2i.json \
  eap-cd-https-s2i.json \
  eap-cd-mongodb-persistent-s2i.json \
  eap-cd-mongodb-s2i.json \
  eap-cd-mysql-persistent-s2i.json \
  eap-cd-mysql-s2i.json \
  eap-cd-postgresql-persistent-s2i.json \
  eap-cd-postgresql-s2i.json \
  eap-cd-sso-s2i.json \
  eap-cd-third-party-db-s2i.json \
  eap-cd-tx-recovery-s2i.json     
do
 echo ${resource}
 oc replace -n ${PROJECT} --force -f templates/$resource
done

oc replace -n ${PROJECT} --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/amq-broker-71/amq-broker-7-image-streams.yaml
for resource in amq-broker-71-basic.yaml \
 amq-broker-71-configmap.yaml
do
 oc replace -n ${PROJECT} --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/amq71-dev/templates/$resource 
done

