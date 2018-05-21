#!/bin/bash -x
LPREFIX=jboss-eap-7
LNAME=eap71-openshift
PREFIX=openshift
NAME=jboss-eap71-openshift
VERSION="1.3"
PORT=5000

oc cluster up # start cluster
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer
oc login -u developer
oc create route edge --service=docker-registry -n default
#curl https://raw.githubusercontent.com/jboss-openshift/application-templates/master/eap/eap71-image-stream.json |  sed -e 's/registry.access.redhat.com\/jboss-eap-7\//openshift\//g' | oc replace --force -n openshift -f -
cat ./eap71-image-stream.json |  sed -e 's/registry.access.redhat.com\/jboss-eap-7\//openshift\//g' | oc replace --force -n openshift -f -
sleep 5
AUTH=`oc whoami -t`
CLUSTER_IP=`oc get -n default svc/docker-registry -o=yaml | grep clusterIP  | awk -F: '{print $2}'`

docker login -u developer -p $AUTH $CLUSTER_IP:$PORT

docker tag $LPREFIX/$LNAME:$VERSION $CLUSTER_IP:$PORT/$PREFIX/$NAME:$VERSION
docker push $CLUSTER_IP:$PORT/$PREFIX/$NAME:$VERSION
