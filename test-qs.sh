oc new-app --template=eap-cd-basic-s2i \
 -p IMAGE_STREAM_NAMESPACE="openshift" \
 -p SOURCE_REPOSITORY_URL="https://github.com/jboss-developer/jboss-eap-quickstarts" \
 -p SOURCE_REPOSITORY_REF="openshift" \
 -p CONTEXT_DIR="" -p ARTIFACT_DIR="kitchensink/target" --build-env="MAVEN_ARGS_APPEND=-pl kitchensink"
