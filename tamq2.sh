#!/bin/bash 

APP_NAME="eap-cd-amq${1}"
PORT=61616
USERNAME="my_username"
PASSWORD="my_password"

MQ_QUEUES="bmtQueue,plainQueue,xaQueue"
MQ_TOPICS="plainTopic,bmtTopic"

MQ_SERVICE_PREFIX_MAPPING="${APP_NAME}-amq7=MQ"

echo oc new-app eap-cd-amq-s2i \
 -p APPLICATION_NAME=${APP_NAME} \
 -p MQ_USERNAME=${USERNAME} \
 -p MQ_PASSWORD=${PASSWORD} \
 -p MQ_QUEUES=${MQ_QUEUES} \
 -p MQ_TOPICS=${MQ_TOPICS}

