# Copyright (C) 2013-2019 Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BANNER = D I V O N A
VERSION = 3.0.0

PYTHON3 = python3
ANSIBLE_VERSION = 2.7.10
MOLECULE_VERSION = 2.20.1
ANSIBLE_VENV = $(DIR)/venv
ANSIBLE_ROLES = $(DIR)/roles/
DEBUG ?=

SHELL = /bin/bash

DIR = $(shell pwd)

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
INFO_COLOR=\033[36m
WHITE_COLOR=\033[1m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

.DEFAULT_GOAL := help

OK=[✅]
KO=[❌]
WARN=[⚠️]


.PHONY: help
help:
	@echo -e "$(OK_COLOR)                  $(BANNER)$(NO_COLOR)"
	@echo "------------------------------------------------------------------"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "${ERROR_COLOR}Usage${NO_COLOR}: make ${INFO_COLOR}<target>${NO_COLOR}\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  ${INFO_COLOR}%-25s${NO_COLOR} %s\n", $$1, $$2 } /^##@/ { printf "\n${WHITE_COLOR}%s${NO_COLOR}\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo -e "$(ERROR_COLOR)Environment variable $* not set$(NO_COLOR)"; \
		exit 1; \
	fi

check-%:
	@if $$(hash $* 2> /dev/null); then \
		echo -e "$(OK_COLOR)$(OK)$(NO_COLOR) $*"; \
	else \
		echo -e "$(ERROR_COLOR)$(KO)$(NO_COLOR) $*"; \
	fi

print-%:
	@if [ "${$*}" == "" ]; then \
		echo -e "$(ERROR_COLOR)[KO]$(NO_COLOR) $* = ${$*}"; \
	else \
		echo -e "$(OK_COLOR)[OK]$(NO_COLOR) $* = ${$*}"; \
	fi

##@ Development

clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(BANNER)] Cleanup$(NO_COLOR)"
	@find . -name "*.retry"|xargs rm

.PHONY: init
init: ## Install requirements
	@echo -e "$(OK_COLOR)[$(BANNER)] Install requirements$(NO_COLOR)"
	@test -d venv || $(PYTHON3) -m venv venv
	@. venv/bin/activate && pip3 install ansible molecule

.PHONY: ping
ping: guard-HOST ## Check Ansible installation (HOST=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Check ansible$(NO_COLOR)"
	@ansible -c local -m ping all -i $(HOST)

.PHONY: lint
lint: guard-ROLE ## Check ansible style (ROLE=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Verify ansible$(NO_COLOR)"
	@cd $(ROLE) && molecule lint

.PHONY: setup-local
setup-local: guard-HOST guard-TAGS guard-USER ## Setup using Ansible (HOST=xxx USER=yyyy TAGS=xxx,xx,xx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Setup using ansible$(NO_COLOR)"
	@ansible-playbook ${DEBUG} -c local -i $(HOST) divona.yml -t $(TAGS) --extra-vars="user=$(USER)"

.PHONY: setup
setup: guard-HOST guard-TAGS guard-USER ## Setup using Ansible (HOST=xxx USER=yyyy TAGS=xxx,xx,xx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Setup using ansible$(NO_COLOR)"
	@ansible-playbook ${DEBUG} -i $(HOST) divona.yml -t $(TAGS) --extra-vars="user=$(USER)"
