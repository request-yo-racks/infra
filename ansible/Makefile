# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

default: setup

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

# preconfigure-minikube: ## Update Kubernetes minikube secrets
# 	. venv/bin/activate \
# 		&& ansible-playbook -i inventory/kubernetes/minikube \
# 			--tags "preconfiguration" \
# 			playbooks/kubernetes.yml


setup: venv ## Setup the full environment
	. venv/bin/activate && ansible-galaxy install -r requirements.yml

venv: venv/bin/activate ## Setup local venv

venv/bin/activate: requirements.txt
	test -d venv || python3 -m venv venv
	. venv/bin/activate && pip install --upgrade pip setuptools && pip install -r requirements.txt

PHONY: setup venv
