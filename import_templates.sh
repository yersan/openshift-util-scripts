#!/bin/bash

# import templates 

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
  oc replace -n openshift --force -f templates/${resource}
done

#  amq/amq63-image-stream.json \
#  processserver/processserver64-image-stream.json \
#  processserver/processserver63-image-stream.json \
#  openjdk/openjdk18-image-stream.json \
#  eap/eap71-image-stream.json \
#  eap/eap64-image-stream.json \
#  eap/eap70-image-stream.json \
#  datavirt/datavirt63-image-stream.json \
#  sso/sso72-image-stream.json
#  sso/sso70-image-stream.json \
#  sso/sso71-image-stream.json \
#  decisionserver/decisionserver63-image-stream.json \
#  decisionserver/decisionserver64-image-stream.json \
#  decisionserver/decisionserver62-image-stream.json \
#  webserver/jws30-tomcat7-image-stream.json \
#  webserver/jws30-tomcat8-image-stream.json \
#  webserver/jws31-tomcat8-image-stream.json \
#  webserver/jws31-tomcat7-image-stream.json \
#  datagrid/datagrid65-image-stream.json \
#  datagrid/datagrid71-image-stream.json




# update the other streams we might need for templates etc
for resource in amq/amq62-image-stream.json \
  amq/amq63-image-stream.json \
  openjdk/openjdk18-image-stream.json \
  eap/eap71-image-stream.json \
  eap/eap64-image-stream.json \
  sso/sso72-image-stream.json 
do
  oc replace -n openshift --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/$resource
done

# eap71 for comparision
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

for resource in amq63-basic.json \
 amq63-persistent-ssl.json \
 amq63-persistent.json \
 amq63-ssl.json 
do
  oc replace -n openshift --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/amq/$resource
done

#AMQ7
oc replace -n openshift --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/amq71-dev/amq-7-image-streams.yaml

for resource in amq-broker-71-basic.yaml \
 amq-broker-71-configmap.yaml
do
  oc replace -n openshift --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/amq71-dev/templates/$resource
done

