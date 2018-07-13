#!/bin/bash

# need to be logged in to OSO before running this.

PROJECT_NAME=zapmyproject1

oc replace -n ${PROJECT_NAME} --force -f https://raw.githubusercontent.com/luck3y/jboss-eap-7-openshift-image/CLOUD-2693/templates/eap-cd-image-stream.json
oc replace -n ${PROJECT_NAME} --force -f https://raw.githubusercontent.com/luck3y/jboss-eap-7-openshift-image/CLOUD-2693/templates/eap-cd-starter-s2i.json

 oc new-app -n ${PROJECT_NAME} --template=eap-cd-starter-s2i -p APPLICATION_NAME=eap-starter-1 -p IMAGE_STREAM_NAMESPACE=${PROJECT_NAME}
