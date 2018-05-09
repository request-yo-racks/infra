# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

CLUSTERS = minikube prod

default: setup

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

clean: clean-repo  ## Clean everything (!DESTRUCTIVE!)

clean-repo: ## Remove unwanted files in project (!DESTRUCTIVE!)
	@cd $(TOPDIR) && git clean -ffdx && git reset --hard

configure-$(CLUSTERS): ## Configure $(CLUSTERS)
	. venv/bin/activate \
		&& ansible-playbook -i inventory/$(lastword $(subst -, ,$@)) \
			--tags "$(firstword $(subst -, ,$@))" \
			playbooks/$(firstword $(subst -, ,$@)).yml

provision-$(CLUSTERS): ## Provision $(CLUSTERS)
	. venv/bin/activate \
		&& ansible-playbook -i inventory/$(lastword $(subst -, ,$@)) \
			--tags "$(firstword $(subst -, ,$@))" \
			playbooks/$(firstword $(subst -, ,$@)).yml

setup: venv ## Setup the full environment
	. venv/bin/activate && ansible-galaxy install -r requirements.yml

venv: venv/bin/activate ## Setup local venv

venv/bin/activate: requirements.txt
	test -d venv || python3 -m venv venv
	. venv/bin/activate && pip install --upgrade pip setuptools && pip install -r requirements.txt

PHONY: setup venv
