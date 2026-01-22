.PHONY: help bootstrap clean test analyze format run

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

bootstrap: ## Bootstrap the monorepo
	dart pub global activate melos
	dart pub global activate mason_cli
	melos bootstrap
	mason get

clean: ## Clean the project
	melos clean

deep-clean: ## Deep clean (removes all generated files)
	melos clean:deep
	rm -rf .dart_tool
	rm -rf build

test: ## Run all tests
	melos test

test-unit: ## Run unit tests
	melos test:unit

test-integration: ## Run integration tests
	melos test:integration

analyze: ## Run static analysis
	melos analyze

format: ## Format all code
	melos format

format-check: ## Check formatting
	melos format:check

verify: ## Verify architecture and dependencies
	melos verify:arch
	melos verify:deps

run-dev: ## Run app in development mode
	cd apps/glow_app && flutter run --flavor dev -t lib/main_dev.dart

run-prod: ## Run app in production mode
	cd apps/glow_app && flutter run --flavor prod -t lib/main_prod.dart

build-runner: ## Run build runner
	melos build:runner

coverage: ## Generate coverage report
	melos coverage

publish-dry: ## Dry run publish
	melos publish:dry
