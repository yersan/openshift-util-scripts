#!/bin/bash 
LPREFIX=jboss-eap-7
LNAME=eap72-openshift
NAMESPACE=openshift
PROJECT_NAME=myproject
NAME=jboss-eap72-openshift
VERSION="1.0"
PORT=5000

BASE_URL=file:///home/kwills/os/git/jboss-eap-7-openshift-image
#BASE_URL=https://raw.githubusercontent.com/jboss-container-images/jboss-eap-7-openshift-image/eap72-dev

# docker tag docker-registry.engineering.redhat.com/bstansbe/eap72-beta-openshift:CLOUD-2694 jboss-eap-7-tech-preview/eap72-openshift:1.0

oc cluster up # start cluster
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer
oc login -u developer
oc create route edge --service=docker-registry -n default
#curl https://raw.githubusercontent.com/jboss-openshift/application-templates/master/eap/eap71-image-stream.json |  sed -e "s/registry.access.redhat.com\/jboss-eap-7\//openshift\//g" | oc replace --force -n ${NAMESPACE} -f -
oc replace --force -n ${PROJECT_NAME} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/eap-app-secret.json
oc replace --force -n ${PROJECT_NAME} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/eap7-app-secret.json
oc replace --force -n ${PROJECT_NAME} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/sso-app-secret.json
sleep 5
AUTH=`oc whoami -t`
CLUSTER_IP=`oc get -n default svc/docker-registry -o=yaml | grep clusterIP  | awk -F: '{print $2}'`

docker login -u developer -p $AUTH $CLUSTER_IP:$PORT

docker tag $LPREFIX/$LNAME:$VERSION $CLUSTER_IP:$PORT/${NAMESPACE}/$NAME:$VERSION
docker push $CLUSTER_IP:$PORT/${NAMESPACE}/$NAME:$VERSION

for resource in eap72-amq-persistent-s2i.json \
  eap72-amq-s2i.json \
  eap72-basic-s2i.json \
  eap72-https-s2i.json \
  eap72-mongodb-persistent-s2i.json \
  eap72-mongodb-s2i.json \
  eap72-mysql-persistent-s2i.json \
  eap72-mysql-s2i.json \
  eap72-postgresql-persistent-s2i.json \
  eap72-postgresql-s2i.json \
  eap72-sso-s2i.json \
  eap72-third-party-db-s2i.json \
  eap72-tx-recovery-s2i.json
do
  curl ${BASE_URL}/templates/$resource | oc replace -n ${NAMESPACE} --force -f -
done

