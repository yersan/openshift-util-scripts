#!/bin/bash

oc -n myproject new-app eap-cd-https-s2i -p APPLICATION_NAME=eap-test-6
