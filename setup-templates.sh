#!/bin/bash -x
LPREFIX=jboss-eap-7-tech-preview
LNAME=eap-cd-openshift
PREFIX=openshift
NAME=eap-cd-openshift
VERSION="13.0"
VERSION_TAG="13"
PORT=5000

oc cluster up # start cluster
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer
oc login -u developer
oc create route edge --service=docker-registry -n default
oc create -n $PREFIX -f templates/eap-cd-image-stream.json
oc create -n myproject -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/secrets/eap-app-secret.json
oc create -n myproject -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/secrets/eap7-app-secret.json
oc create -n myproject -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/secrets/sso-app-secret.json
sleep 5
AUTH=`oc whoami -t`
CLUSTER_IP=`oc get -n default svc/docker-registry -o=yaml | grep clusterIP  | awk -F: '{print $2}'`
docker tag $LPREFIX/$LNAME:latest $LPREFIX/$LNAME:$VERSION

docker login -u developer -p $AUTH $CLUSTER_IP:$PORT
#jboss-eap-7-tech-preview/eap-cd-openshift:$VERSION
docker tag $LPREFIX/$LNAME:$VERSION $CLUSTER_IP:$PORT/$PREFIX/$NAME:$VERSION
docker tag $LPREFIX/$LNAME:$VERSION $CLUSTER_IP:$PORT/$PREFIX/$NAME:$VERSION_TAG
docker tag $LPREFIX/$LNAME:$VERSION $CLUSTER_IP:$PORT/$PREFIX/$NAME:latest
docker push $CLUSTER_IP:$PORT/$PREFIX/$NAME:$VERSION
docker push $CLUSTER_IP:$PORT/$PREFIX/$NAME:$VERSION_TAG
docker push $CLUSTER_IP:$PORT/$PREFIX/$NAME:latest
