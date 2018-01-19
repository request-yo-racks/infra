#!/bin/bash
set -euo pipefail

if ! kubectl get secret ryr-api-secrets >/dev/null; then
  kubectl create secret generic ryr-api-secrets --from-file="${HOME}/.config/ryr/kubernetes-secrets"
fi
