#!/bin/bash

dc=`oc get dc 2>&1 | grep -v NAME | grep -v 'No resource' | awk '{print $1}'`
if [ "${#dc[@]}" -ne 0 ]; then
  for d in ${dc[@]} 
    do
      echo $d
      oc delete dc ${d}
    done
else
 echo No DCs found
fi

pods=`oc get pods 2>&1 | grep -v NAME | grep -v 'No resour' | awk '{print $1}'`
if [ "${#pods[@]}" -ne 0 ]; then
  for p in ${pods[@]} 
    do
     echo $p
     oc delete pod ${p}
    done
fi
