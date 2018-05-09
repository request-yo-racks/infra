# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

default: setup

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

export-minikube: ## Export minikube configmap and secrets
	. venv/bin/activate \
		&& ansible-playbook -i inventory/kubernetes/minikube \
			--tags "export" \
			playbooks/export.yml
	@echo -e "The environment file was created in $$HOME/.config/env.\nRun the following command to load it:\nsource $$HOME/.config/env\n"

export-qa: ## Export QA configmap and secrets
	. venv/bin/activate \
		&& ansible-playbook -i inventory/kubernetes/qa \
			--tags "export" \
			playbooks/export.yml
	@echo -e "The environment file was created in $$HOME/.config/env.\nRun the following command to load it:\nsource $$HOME/.config/env\n"

export-prod: ## Export prod configmap and secrets
	. venv/bin/activate \
		&& ansible-playbook -i inventory/kubernetes/prod \
			--tags "export" \
			playbooks/export.yml
	@echo -e "The environment file was created in $$HOME/.config/env.\nRun the following command to load it:\nsource $$HOME/.config/env\n"

export-stage: ## Export stage configmap and secrets
	. venv/bin/activate \
		&& ansible-playbook -i inventory/kubernetes/stage \
			--tags "export" \
			playbooks/export.yml
	@echo -e "The environment file was created in $$HOME/.config/env.\nRun the following command to load it:\nsource $$HOME/.config/env\n"

preconfigure-minikube: ## Update Kubernetes minikube secrets
	. venv/bin/activate \
		&& ansible-playbook -i inventory/kubernetes/minikube \
			--tags "preconfiguration" \
			playbooks/kubernetes.yml

preconfigure-prod: ## Update Kubernetes production secrets
	. venv/bin/activate && \
		ansible-playbook -i inventory/kubernetes/prod \
			--tags "preconfiguration" \
			playbooks/kubernetes.yml

preconfigure-qa: ## Update Kubernetes QA secrets
	. venv/bin/activate && \
		ansible-playbook -i inventory/kubernetes/qa \
			--tags "preconfiguration" \
			playbooks/kubernetes.yml

preconfigure-stage: ## Update Kubernetes stage secrets
	. venv/bin/activate && \
		ansible-playbook -i inventory/kubernetes/stage \
			--tags "preconfiguration" \
			playbooks/kubernetes.yml

setup: venv ## Setup the full environment
	. venv/bin/activate && ansible-galaxy install -r requirements.yml

venv: venv/bin/activate ## Setup local venv

venv/bin/activate: requirements.txt
	test -d venv || python3 -m venv venv
	. venv/bin/activate && pip install -U pip setuptools && pip install -r requirements.txt

PHONY: preconfigure-minikube preconfigure-prod preconfigure-qa preconfigure-stage setup
