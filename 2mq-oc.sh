#!/bin/bash

#updated with the current tagged dev version of EAP, e.g. 1.3
oc replace -n openshift --force -f eap71-basic-s2i.json

for resource in amq63-basic.json \
 amq63-persistent-ssl.json \
 amq63-persistent.json \
 amq63-ssl.json 
do
  oc replace -n openshift --force -f https://raw.githubusercontent.com/luck3y/application-templates/master/amq/$resource
done

oc new-app eap71-basic-s2i \
-p APPLICATION_NAME=eap71-$1 \
-e MQ_SERVICE_PREFIX_MAPPING="broker1-amq=BROKER1_MQ broker2-amq=BROKER2_MQ" \
-e BROKER1_AMQ_TCP_SERVICE_HOST=broker1-amq-tcp \
-e BROKER1_AMQ_TCP_SERVICE_PORT=61616 \
-e BROKER1_MQ_USERNAME=test1user \
-e BROKER1_MQ_PASSWORD=test1pass \
-e BROKER2_AMQ_TCP_SERVICE_HOST=broker2-amq-tcp \
-e BROKER2_AMQ_TCP_SERVICE_PORT=61616 \
-e BROKER2_MQ_USERNAME=test2user \
-e BROKER2_MQ_PASSWORD=test2pass 

