#!/bin/bash

# quick, hacky cleanup of everything in OS
# (currently doesn't delete persistent vols)

for i in pods dc builds bc services routes
do
 echo $i
 oc get $i | grep -v NAME | awk '{print $1}'  | xargs oc delete $i
done

