#!/bin/bash
set -euo pipefail

kubectl create secret generic ryr-api-secrets --from-file=~/.config/ryr/kubernetes-secrets
