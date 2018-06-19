#!/bin/bash

oc -n myproject new-app eap-cd-basic-s2i \
 -p APPLICATION_NAME=eap-clustering-${1} \
 -e JGROUPS_PING_PROTOCOL=openshift.KUBE_PING \
 -e JGROUPS_ENCRYPT_KEYSTORE_DIR=/etc/jgroups-encrypt-secret-volume \
 -e JGROUPS_ENCRYPT_SECRET=eap7-app-secret \
 -e JGROUPS_ENCRYPT_KEYSTORE=jgroups.jceks \
 -e JGROUPS_ENCRYPT_NAME="secret-key" \
 -e JGROUPS_ENCRYPT_PASSWORD="password" \
 -e OPENSHIFT_KUBE_PING_NAMESPACE="myproject" \
 -e OPENSHIFT_KUBE_PING_LABELS="app=eap-cd-basic-s2i"

## XXXX
oc policy add-role-to-user cluster-admin system:serviceaccount:myproject:default"
