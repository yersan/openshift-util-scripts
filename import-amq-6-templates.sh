NAMESPACE=openshift

for resource in amq/amq63-image-stream.json
do
  oc replace -n ${NAMESPACE} --force -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/$resource
done

