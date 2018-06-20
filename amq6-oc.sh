#!/bin/bash

oc new-app eap71-amq-persistent-s2i \
-p APPLICATION_NAME=jbamq$1 \
-e MQ_SERVICE_PREFIX_MAPPING="jbamq$1-amq=JBAMQ" \
-e JBAMQ_AMQ_TCP_SERVICE_HOST=jbamqi$1-amq-tcp \
-e JBAMQ_AMQ_TCP_SERVICE_PORT=61616 \
-e JBAMQ_USERNAME=test1user \
-e JBAMQ_PASSWORD=test1pass \
-e JBAMQ_QUEUES=bmtQueue,HELLOWORLDMDBQueue \
-e JBAMQ_TOPICS=HELLOWORLDMDBTopic

#export MQ_SERVICE_PREFIX_MAPPING="jbamq-amq7=JBAMQ"
#export JBAMQ_AMQ_TCP_SERVICE_HOST=jbamq-amq-tcp
#export JBAMQ_AMQ_TCP_SERVICE_PORT=61616
#export JBAMQ_USERNAME=test1user
#export JBAMQ_PASSWORD=test1pass
#export JBAMQ_QUEUES=bmtQueue
