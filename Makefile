SHELL := /bin/bash
IMAGE_NAME ?= lecrev/base
BATS ?= bats

.PHONY: lint lint-docker lint-scripts test test-image test-install install-deps

define check_tool
	@if ! command -v $(1) >/dev/null 2>&1; then \
		echo "Missing dependency: $(1). Install it and retry." >&2; \
		exit 1; \
	fi
endef

lint: lint-docker lint-scripts

lint-docker:
	$(call check_tool,hadolint)
	hadolint infra/base-image/Dockerfile

lint-scripts:
	$(call check_tool,shellcheck)
	shellcheck scripts/*.sh

install-deps:
	$(call check_tool,npm)
	npm install

test: lint test-image test-install

test-image:
	$(call check_tool,docker)
	$(call check_tool,$(BATS))
	docker build -t $(IMAGE_NAME) infra/base-image
	$(BATS) tests/infra/base-image.bats

test-install:
	$(call check_tool,$(BATS))
	$(BATS) tests/scripts/install-base-deps.bats tests/scripts/deploy-mock.bats
