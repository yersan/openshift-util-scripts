#TEMPLATE_SRC=https://raw.githubusercontent.com/jboss-container-images/jboss-eap-7-openshift-image/eap-cd-dev/templates/
#TEMPLATE_SRC=https://raw.githubusercontent.com/jboss-container-images/jboss-eap-7-openshift-image/eap-cd/templates/
TEMPLATE_SRC=/home/kwills/os/git/jboss-eap-7-openshift-image/templates
NAMESPACE=openshift

for resource in \
  eap-cd-amq-persistent-s2i.json \
  eap-cd-amq-s2i.json \
  eap-cd-basic-s2i.json \
  eap-cd-https-s2i.json \
  eap-cd-mongodb-persistent-s2i.json \
  eap-cd-mongodb-s2i.json \
  eap-cd-mysql-persistent-s2i.json \
  eap-cd-mysql-s2i.json \
  eap-cd-postgresql-persistent-s2i.json \
  eap-cd-postgresql-s2i.json \
  eap-cd-third-party-db-s2i.json \
  eap-cd-tx-recovery-s2i.json \
  eap-cd-sso-s2i.json
do
 oc replace -n ${NAMESPACE} --force -f ${TEMPLATE_SRC}/${resource}
done
