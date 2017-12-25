# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

minikube-delete: ## Delete the minikube cluster
	@minikube docker-env -u
	@minikube delete

minikube-start: ## Setup/Start Minikube
	@bash minikube-setup.sh

minikube-stop: ## Stop Minikube
	@minikube stop
