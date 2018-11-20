NAMESPACE=openshift

curl https://raw.githubusercontent.com/jboss-openshift/application-templates/master/amq/amq63-image-stream.json | sed -e 's/registry.redhat.io/registry.access.redhat.com/g' | oc replace -n ${NAMESPACE} --force -f -

