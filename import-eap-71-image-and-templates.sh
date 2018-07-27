#!/bin/bash -x
LPREFIX=jboss-eap-7
LNAME=eap71-openshift
NAMESPACE=openshift
NAME=jboss-eap71-openshift
VERSION="1.4"
PORT=5000

oc cluster up # start cluster
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer
oc login -u developer
oc create route edge --service=docker-registry -n default
#curl https://raw.githubusercontent.com/jboss-openshift/application-templates/master/eap/eap71-image-stream.json |  sed -e 's/registry.access.redhat.com\/jboss-eap-7\//openshift\//g' | oc replace --force -n openshift -f -
cat ./eap71-image-stream.json |  sed -e 's/registry.access.redhat.com\/jboss-eap-7\//openshift\//g' | oc replace --force -n openshift -f -
oc create -n myproject -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/eap-app-secret.json
oc create -n myproject -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/eap7-app-secret.json
oc create -n myproject -f https://raw.githubusercontent.com/luck3y/application-templates/master/secrets/sso-app-secret.json
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
  oc replace -n openshift --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/eap/$resource
done

