#!/bin/bash
set -euo pipefail

kubectl create secret generic ryr-api-secrets --from-file="${HOME}/.config/ryr/kubernetes-secrets"
