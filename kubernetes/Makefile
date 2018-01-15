# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

configure: ## Configure minikube and external services
	@cd configure && bash configure-secrets.sh
	@cd configure/external-services && bash configure-external-services.sh

helm: ## Setup Helm client, server and repositories
	@helm init
	@helm repo add ryr https://request-yo-racks.github.io/charts/
	@helm repo update

minikube: # Setup minikube, REX ConfigMap, and ECR access.
	@$(MAKE) -C provision/minikube minikube-start

provision: minikube helm ## Provision the minikube cluster

unprovision: ## Unprovision the minikube cluster
	$(MAKE) -C provision/minikube minikube-delete

.PHONY: help configure helm minikube provision unprovision
