#!/bin/bash

oc new-app eap-cd-amq-s2i \
-p APPLICATION_NAME=eap-cd-amq7-test-$1 \
-e MQ_SERVICE_PREFIX_MAPPING="eap-cd-amq7-test-$1-amq7=MQ" \
-e BROKER1_AMQ_TCP_SERVICE_HOST=broker1-amq-tcp \
-e BROKER1_AMQ_TCP_SERVICE_PORT=61616 \
-e BROKER1_MQ_USERNAME=test1user \
-e BROKER1_MQ_PASSWORD=test1pass 

