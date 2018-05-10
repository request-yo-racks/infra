#!/bin/bash
set -euo pipefail

# Define variables.
: ${HELM_ENV:=minikube}
: ${HELM_EXTRA_OPTS:=""}

# Configure the required services.
SERVICES="postgresql:0.9.5 redis:3.0.1"
for svc in ${SERVICES}; do

  # Extract parts.
  service=$(echo "${svc}" | cut -d':' -f 1)
  version=$(echo "${svc}" | cut -d':' -f 2)

  # Look for values to inject.
  INJECT=""
  if [ -f "${service}/extras.${HELM_ENV}.yaml" ]; then
    INJECT=$(bash ${service}/extras.${HELM_ENV}.yaml)
  fi

  helm upgrade --install \
    --values "${service}/values.common.yaml" \
    --values "${service}/values.${HELM_ENV}.yaml" \
    ${INJECT} \
    --version "${version}" \
    "${service}" \
    ${HELM_EXTRA_OPTS} \
    "stable/${service}"
done

# List all the services.
helm ls
if [ "${HELM_ENV}" == minikube ]; then
  minikube service list
fi
