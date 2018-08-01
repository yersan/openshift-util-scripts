#!/bin/bash -x
LPREFIX=jboss-eap-7
LNAME=eap71-openshift
NAMESPACE=openshift
PROJECT_NAME=myproject
NAME=jboss-eap71-openshift
VERSION="1.4"
PREV_VERSION="1.3"
PORT=5000

oc cluster up # start cluster
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer
oc login -u developer
oc create route edge --service=docker-registry -n default
curl https://raw.githubusercontent.com/jboss-openshift/application-templates/master/eap/eap71-image-stream.json |  sed -e "s/registry.access.redhat.com\/jboss-eap-7\//openshift\//g" | sed -e "s/${PREV_VERSION}/${VERSION}/g" | oc replace --force -n ${NAMESPACE} -f -
oc replace --force -n ${PROJECT_NAME} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/eap-app-secret.json
oc replace --force -n ${PROJECT_NAME} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/eap7-app-secret.json
oc replace --force -n ${PROJECT_NAME} -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/sso-app-secret.json
sleep 5
AUTH=`oc whoami -t`
CLUSTER_IP=`oc get -n default svc/docker-registry -o=yaml | grep clusterIP  | awk -F: '{print $2}'`

docker login -u developer -p $AUTH $CLUSTER_IP:$PORT

docker tag $LPREFIX/$LNAME:$VERSION $CLUSTER_IP:$PORT/${NAMESPACE}/$NAME:$VERSION
docker push $CLUSTER_IP:$PORT/${NAMESPACE}/$NAME:$VERSION

for resource in eap71-amq-persistent-s2i.json \
  eap71-amq-s2i.json \
  eap71-basic-s2i.json \
  eap71-https-s2i.json \
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
  curl https://raw.githubusercontent.com/jboss-openshift/application-templates/master/eap/$resource | sed -e "s/${NAME}:${PREV_VERSION}/${NAME}:${VERSION}/g" | oc replace -n ${NAMESPACE} --force -f -
done

