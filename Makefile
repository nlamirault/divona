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

APP = divona
VERSION = 3.0.0

PYTHON3 = python3
ANSIBLE_VERSION = 2.7.6

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

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo -e "$(ERROR_COLOR)Environment variable $* not set$(NO_COLOR)"; \
		exit 1; \
	fi

clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(APP)] Cleanup$(NO_COLOR)"
	@find . -name "*.retry"|xargs rm

.PHONY: init
init: ## Install requirements
	@echo -e "$(OK_COLOR)[$(APP)] Install requirements$(NO_COLOR)"
	@test -d venv || $(PYTHON3) -m venv venv
	@. venv/bin/activate && pip3 install ansible molecule

.PHONY: ping
ping: guard-DIVONA_HOST ## Check Ansible installation (HOST=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Check ansible$(NO_COLOR)"
	@ansible -c local -m ping all -i $(DIVONA_HOST)

.PHONY: lint
lint: guard-ROLE ## Check ansible style (ROLE=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Verify ansible$(NO_COLOR)"
	@cd $(ROLE) && molecule lint

.PHONY: setup-local
setup-local: guard-HOST guard-TAGS guard-USER ## Setup using Ansible (HOST=xxx USER=yyyy TAGS=xxx,xx,xx)
	@echo -e "$(OK_COLOR)[$(APP)] Setup using ansible$(NO_COLOR)"
	@ansible-playbook ${DEBUG} -c local -i $(HOST) divona.yml -t $(TAGS) --extra-vars="user=$(USER)"

.PHONY: setup
setup: guard-HOST guard-TAGS guard-USER ## Setup using Ansible (HOST=xxx USER=yyyy TAGS=xxx,xx,xx)
	@echo -e "$(OK_COLOR)[$(APP)] Setup using ansible$(NO_COLOR)"
	@ansible-playbook ${DEBUG} -i $(HOST) divona.yml -t $(TAGS) --extra-vars="user=$(USER)"

.PHONY: docker-build
docker-build: guard-IMAGE ## Build a Docker image (IMAGE=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Docker build $(IMAGE)$(NO_COLOR)"
	@docker build -t divona-$(IMAGE) -f dockerfiles/Dockerfile.$(IMAGE) --build-arg ANSIBLE_VERSION=$(ANSIBLE_VERSION) dockerfiles

.PHONY: docker-publish
docker-publish: guard-IMAGE ## Publish the Divona image (IMAGE=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Docker publish $(IMAGE)$(NO_COLOR)"
	@docker tag divona-$(IMAGE) nlamirault/divona:$(IMAGE)
	@docker push nlamirault/divona:$(IMAGE)

.PHONY: docker-run
docker-run: guard-IMAGE guard-PLAYBOOK ## Run Ansible using a Docker image (IMAGE=xxx PLAYBOOK=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Run Ansible playbook using Docker image $(IMAGE) for host $(LOCAL)$(NO_COLOR)"
	docker run --rm -i \
		-v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
		-v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
		-v $$(pwd)/ansible:/ansible/playbooks \
		divona-$(IMAGE) ansible-playbook -vvv -c local -i /ansible/playbooks/hosts/local /ansible/playbooks/$(PLAYBOOK) --extra-vars="user=root"

.PHONY: docker-debug
docker-debug: guard-IMAGE ## Run a bash from a Docker image (IMAGE=xxx)
	@echo -e "$(OK_COLOR)[$(APP)] Run Ansible playbook using Docker image $(IMAGE) for host $(LOCAL)$(NO_COLOR)"
	docker run --rm -i \
		-v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
		-v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
		-v $$(pwd)/ansible:/ansible/playbooks \
		divona-$(IMAGE) /bin/bash

