# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
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

APP = divona

VERSION = 3.0.0

PYTHON3 = python3

ANSIBLE_VERSION = 5.0.1
MOLECULE_VERSION = 3.5.2
ANSIBLE_VENV = $(DIR)/venv
ANSIBLE_ROLES = $(DIR)/roles/

ANSIBLE_PLAYBOOK ?= divona.yml

DEBUG ?=
TAGS ?=

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

# ====================================
# D E V E L O P M E N T
# ====================================

##@ Development

clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(APP)] Cleanup$(NO_COLOR)"
	@find . -name "*.retry"|xargs rm -fr {} \;
	@rm -fr roles

.PHONY: validate
validate: ## Execute git-hooks
	@pre-commit run -a

.PHONY: license
license: guard-ACTION ## Check license (ACTION=xxx : fix or check)
	@docker run -it --rm -v $(shell pwd):/github/workspace ghcr.io/apache/skywalking-eyes/license-eye --config /github/workspace/.licenserc.yaml header $(ACTION)



# ====================================
# A N S I B L E
# ====================================

##@ Ansible

.PHONY: ansible-init
ansible-init: ## Bootstrap Ansible
	@echo -e "$(OK_COLOR)[$(APP)] Install requirements$(NO_COLOR)"
	@test -d venv || $(PYTHON3) -m venv venv
	@. venv/bin/activate && pip3 install ansible==$(ANSIBLE_VERSION) molecule==$(MOLECULE_VERSION)

.PHONY: ansible-deps
ansible-deps: ## Install dependencies
	@echo -e "$(OK_COLOR)[$(APP)] Install dependencies$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ansible-galaxy install -r divona/roles/requirements.yml -p $(ANSIBLE_ROLES) --force \
		&& ansible-galaxy collection install -r divona/roles/requirements.yml -p $(ANSIBLE_ROLES) --force

.PHONY: ansible-ping
ansible-ping: guard-ENV ## Check Ansible installation (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Check Ansible$(NO_COLOR)"
	@@. $(ANSIBLE_VENV)/bin/activate \
		&& ansible -c local -m ping all -i $(ENV)

.PHONY: ansible-debug
ansible-debug: guard-ENV ## Retrieve informations from hosts (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Check Ansible$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ansible -m setup all -i $(ENV)

.PHONY: ansible-run
ansible-run: guard-ENV ## Execute Ansible playbook (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Execute Ansible playbook$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ansible-playbook ${DEBUG} -c local -i $(ENV) $(ANSIBLE_PLAYBOOK) --extra-vars="user=$(USER) $(TAGS)"

.PHONY: ansible-dryrun
ansible-dryrun: guard-ENV ## Execute Ansible playbook (ENV=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Execute Ansible playbook$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ansible-playbook ${DEBUG} -c local -i $(ENV) $(ANSIBLE_PLAYBOOK) --check
