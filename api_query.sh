#!/bin/sh

# Source: https://github.com/nirgeier/KubernetesLabs/blob/master/Labs/21-KubeAPI/README.md#0101-The-script-which-will-be-used-for-query-K8S-API
#################################
## Access the internal K8S API ##
#################################
# Point to the internal API server hostname
API_SERVER_URL=https://kubernetes.default.svc

# Path to ServiceAccount token
# The service account is mapped by the K8S Api server in the pods
SERVICE_ACCOUNT_FOLDER=/var/run/secrets/kubernetes.io/serviceaccount

# Read this Pod's namespace if required
# NAMESPACE=$(cat ${SERVICE_ACCOUNT_FOLDER}/namespace)

# Read the ServiceAccount bearer token
TOKEN=$(cat ${SERVICE_ACCOUNT_FOLDER}/token)

# Reference the internal certificate authority (CA)
CACERT=${SERVICE_ACCOUNT_FOLDER}/ca.crt

# Explore the API with TOKEN and the Certificate
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${API_SERVER_URL}/api
