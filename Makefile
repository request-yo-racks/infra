# Makefile variables.
SHELL = /bin/bash

# Misc.
TOPDIR = $(shell git rev-parse --show-toplevel)
BIN_DIR = bin

# Request-yo-racks.
RYR_PROJECTS = api docs infra web charts

default: setup

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

apply-labels:
	# echo $(RYR_PROJECTS) | xargs -n 1 -I {} node_modules/.bin/glm -u request-yo-racks import request-yo-racks:{} third-party/github/labels.json
	echo $(RYR_PROJECTS) | xargs -n 1 -I {} ./bin/labeler apply -r request-yo-racks/{} third-party/github/labels.yaml

clean: ## Remove unwanted files in project (!DESTRUCTIVE!)
	cd $(TOPDIR) && git clean -ffdx && git reset --hard

labeler:
	@bash tools/labeler-install.sh

setup: labeler ## Setup the full environment


.PHONY: apply-labels clean docs github-label-manager help labeler setup
