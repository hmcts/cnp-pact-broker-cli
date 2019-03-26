.DEFAULT_GOAL:= help
.REGISTRY = hmcts.azurecr.io
.SANDBOX_REGISTRY = hmctssandbox.azurecr.io
.IMAGE_NAME = pact-broker-cli

.PHONY: help ## Display help section
help:
	@echo ""
	@echo "  Available commands:"
	@echo ""
	@grep -E '^\.PHONY: [a-zA-Z_-]+ .*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = "(: |##)"}; {printf "\033[36m  make %-15s\033[0m %s\n", $$2, $$3}'
	@echo ""

.PHONY: build ## Build image for hmcts registry
build:
	docker build \
		-t $(.REGISTRY)/$(.IMAGE_NAME) \
		.

.PHONY: test ## Tests the newly build image
test:
	@sh ./test.sh $(.REGISTRY)/$(.IMAGE_NAME) latest

.PHONY: build-sandbox ## Build image for hmctssandbox registry
build-sandbox:
	docker build \
		-t $(.SANDBOX_REGISTRY)/$(.IMAGE_NAME) \
		.

.PHONY: dockerhub-build ## Build image for dockerbub hosted hmcts registry
dockerhub-build:
	docker build \
		-t hmcts/$(.IMAGE_NAME) \
		.
