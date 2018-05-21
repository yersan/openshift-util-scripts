#!/bin/bash

 docker run \
  -it \
  -e MQ_SERVICE_PREFIX_MAPPING="test1-amq=TEST1_MQ test2-amq=TEST2_MQ" \
  -e TEST1_AMQ_TCP_SERVICE_HOST=test1host \
  -e TEST1_AMQ_TCP_SERVICE_PORT=9999 \
  -e TEST1_MQ_USERNAME=test1user \
  -e TEST1_MQ_PASSWORD=test1pass \
  -e TEST2_AMQ_TCP_SERVICE_HOST=test2host \
  -e TEST2_AMQ_TCP_SERVICE_PORT=9999 \
  -e TEST2_MQ_USERNAME=test2user \
  -e TEST2_MQ_PASSWORD=test2pass \
  jboss-eap-7/eap71-openshift \
  /bin/bash
