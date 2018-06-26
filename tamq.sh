#!/bin/bash

APP_NAME="eap-app"
PORT=61616
USERNAME="my_username"
PASSWORD="my_password"

MQ_QUEUES="bmtQueue,plainQueue,xaQueue"
MQ_TOPICS="plainTopic,bmtTopic"

MQ_SERVICE_PREFIX_MAPPING="${APP_NAME}-amq7=MQ"
echo "MQ_SERVICE_PREFIX_MAPPING: $MQ_SERVICE_PREFIX_MAPPING"

IFS=',' read -a brokers <<< $MQ_SERVICE_PREFIX_MAPPING
echo "brokers: ${brokers}"

for broker in ${brokers[@]}; do
service_name=${broker%=*}
echo "service_name: ${service_name}"
service=${service_name^^}
echo "service: ${service}"
service=${service//-/_}
echo "service: ${service}"
type=${service##*_}
echo "type: ${type}"
prefix=${broker#*=}
echo "prefix: ${prefix}"

protocol="tcp"
protocol_env=${protocol//[-+.]/_}
protocol_env=${protocol_env^^}

echo "Lookup: ${service}_${protocol_env}_SERVICE_HOST"

done
