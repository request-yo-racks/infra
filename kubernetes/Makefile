# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

configure: ## Configure minikube and external services
	@eval $(minikube docker-env) && cd configure && bash configure-secrets.sh
	@eval $(minikube docker-env) && cd configure/external-services && bash configure-external-services.sh

minikube: # Setup minikube, REX ConfigMap, and ECR access.
	@$(MAKE) -C provision/minikube minikube-start

provision: minikube ## Provision the minikube cluster

unprovision: ## Unprovision the minikube cluster
	$(MAKE) -C provision/minikube minikube-delete

.PHONY: help configure helm minikube provision unprovision
