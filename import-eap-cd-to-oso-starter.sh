#!/bin/bash

TOKEN=`oc whoami -t`
EMAIL="ken@zaptillion.net"
USER="ken@zaptillion.net"
CLUSTER="starter-us-west-1"
SRCIMG=jboss-eap-7-tech-preview/eap-cd-openshift:13.0
TGTIMG=eap-cd-openshift:13.0
REGISTRY=registry.${CLUSTER}.openshift.com
IS_TAG=13

NAMESPACE=zapmyproject
DEFAULT_NAMESPACE=openshift

docker login -u ${USER} -e ${EMAIL} \
    -p ${TOKEN} https://${REGISTRY}

docker tag ${SRCIMG} ${REGISTRY}/${NAMESPACE}/${TGTIMG}
docker push ${REGISTRY}/${NAMESPACE}/${TGTIMG}
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
 curl https://raw.githubusercontent.com/luck3y/jboss-eap-7-openshift-image/oso-template/templates/$resource | sed -e "s|NAMESPACE|${NAMESPACE}|g" | sed -e "s|DEFAULT_NAMESPACE|${DEFAULT_NAMESPACE}|g" | oc replace -n ${NAMESPACE} --force -f -
done

oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/amq-broker-71/amq-broker-7-image-streams.yaml
for resource in amq-broker-71-basic.yaml \
 amq-broker-71-configmap.yaml
do
 oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/amq71-dev/templates/$resource 
done

oc create -n ${NAMESPACE} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/eap-app-secret.json
oc create -n ${NAMESPACE} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/eap7-app-secret.json
oc create -n ${NAMESPACE} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/sso-app-secret.json

