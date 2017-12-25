#!/bin/bash
set -euo pipefail

SERVICES="postgresql rabbitmq redis"
for service in ${SERVICES}; do
  helm upgrade --install \
    --values "${service}/values.minikube.yaml" \
    "${service}" \
    "stable/${service}"
done
