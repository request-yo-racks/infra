# Makefile variables.
SHELL = /bin/bash

# Misc.
TOPDIR = $(shell git rev-parse --show-toplevel)

# Request-yo-racks.
RYR_PROJECTS = api docs infra web

default: setup

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

clean: ## Remove unwanted files in project (!DESTRUCTIVE!)
	cd $(TOPDIR); git clean -ffdx && git reset --hard

github-labels: setup ## Import standard labels to ALL projects
	echo $(RYR_PROJECTS) | xargs -n 1 -I {} node_modules/.bin/glm -u request-yo-racks import request-yo-racks:{} third-party/github/labels.json

setup: ## Setup the full environment
	@npm install github-label-manager

.PHONY:clean docs github-labels help setup
