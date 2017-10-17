# Copyright (C) 2013-2017 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

APP = divona
VERSION = 1.1.0

DEBUG ?=

SHELL = /bin/bash

DIR = $(shell pwd)

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo -e "$(OK_COLOR)==== $(APP) [$(VERSION)] ====$(NO_COLOR)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(MAKE_COLOR) : %s\n", $$1, $$2}'

clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(APP)] Cleanup$(NO_COLOR)"
	@rm -fr $(EXE) $(EXE)-$(VERSION)_* $(APP)-*.tar.gz

.PHONY: init
init: ## Install requirements
	@echo -e "$(OK_COLOR)[$(APP)] Install requirements$(NO_COLOR)"
	@echo "Install : ansible ansible-lint"

.PHONY: ping
ping: ## Check Ansible installation
	@echo -e "$(OK_COLOR)[$(APP)] Check ansible$(NO_COLOR)"
	@ansible -c local -m ping all -i $(host)

.PHONY: lint
lint: ## Check ansible style
	@echo -e "$(OK_COLOR)[$(APP)] Verify ansible$(NO_COLOR)"
	@for i in $$(find ansible/ -name "*.yml"); do echo $$i; ansible-lint $$i; done

.PHONY: default
default: ## Default environment
	@echo -e "$(OK_COLOR)[$(APP)] Configure using default$(NO_COLOR)"
	@ansible-playbook ${DEBUG} -c local -i $(host) ansible/divona.yml --extra-vars="user=$(user)"

.PHONY: dev
dev: ## Development environment
	@echo -e "$(OK_COLOR)[$(APP)] Install development environment$(NO_COLOR)"
	@ansible-playbook ${DEBUG} -c local -i $(host) ansible/dev.yml --extra-vars="user=$(user)"

.PHONY: iot
iot: ## Internet Of Things
	@echo -e "$(OK_COLOR)[$(APP)] Install IOT environment$(NO_COLOR)"
	@ansible-playbook ${DEBUG} -c local -i $(host) ansible/iot.yml --extra-vars="user=$(user)"

.PHONY: mobile
mobile: ## Mobile
	@echo -e "$(OK_COLOR)[$(APP)] Install mobile development environment$(NO_COLOR)"
	@ansible-playbook ${DEBUG} -c local -i $(host) ansible/mobile.yml --extra-vars="user=$(user)"

.PHONY: docker-build
docker-build: ## Build a Docker image
	@echo -e "$(OK_COLOR)[$(APP)] Docker build $(image)$(NO_COLOR)"
	@docker build -t divona-$(image) -f dockerfiles/Dockerfile.$(image) dockerfiles

.PHONY: docker-publish
docker-publish: ## Publish the Divona image
	@echo -e "$(OK_COLOR)[$(APP)] Docker publish $(image)$(NO_COLOR)"
	@docker tag divona-$(image) nlamirault/divona:$(image)
	@docker push nlamirault/divona:$(image)

.PHONY: docker-run
docker-run: ## Run Ansible using a Docker image
	@echo -e "$(OK_COLOR)[$(APP)] Run Ansible playbook using Docker image $(image) for host $(local)$(NO_COLOR)"
	@docker run --rm -i \
		-v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
		-v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
		-v `pwd`/ansible:/ansible/playbooks \
		divona-$(image) ansible-playbook -vvv -c local -i /ansible/playbooks/hosts/local /ansible/playbooks/$(playbook) --extra-vars="user=root"
