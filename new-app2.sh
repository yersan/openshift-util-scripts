#!/bin/sh
oc new-app --template=eap-cd-basic-s2i \
 -p IMAGE_STREAM_NAMESPACE="openshift" \
 -p SOURCE_REPOSITORY_URL="https://github.com/jboss-developer/jboss-eap-quickstarts" \
 -p SOURCE_REPOSITORY_REF="openshift" \
 -p CONTEXT_DIR="kitchensink" \
 -p APPLICATION_NAME="eap-test-323456"
