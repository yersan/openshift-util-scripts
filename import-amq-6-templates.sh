for resource in amq/amq63-image-stream.json
do
  oc replace -n openshift --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/$resource
done

