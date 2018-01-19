#!/bin/bash
set -euo pipefail

# Configure the required services.
SERVICES="postgresql rabbitmq redis"
for service in ${SERVICES}; do
  helm upgrade --install \
    --values "${service}/values.minikube.yaml" \
    "${service}" \
    "stable/${service}"
done

# List all the services.
minikube service list
