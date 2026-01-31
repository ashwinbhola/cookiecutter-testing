# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
PYTHON_VERSION = 3.14
VENV           = .venv
PART           ?= minor

# Logic: Use the virtual environment if not running in GitHub Actions
ifeq ($(GITHUB_ACTIONS), true)
    PYTHON = python
    PIP    = pip
    BIN    = .
else
    BIN    = $(VENV)/bin
    PYTHON = $(BIN)/python
    PIP    = $(BIN)/pip
endif

# ------------------------------------------------------------------------------
# Commands
# ------------------------------------------------------------------------------
.DEFAULT_GOAL := help
.PHONY: help venv install-requirements fix-lint lint test bump release reset-venv

## help: Show this help message
help:
	@echo "Usage: make [target] [part=major|minor|patch]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

venv:  ## Create virtual environment if it doesn't exist (Local only)
ifndef GITHUB_ACTIONS
	@test -d $(VENV) || python$(PYTHON_VERSION) -m venv $(VENV)
	@$(PIP) install --upgrade pip
endif

install-requirements: venv  ## Install core and development dependencies
	$(PIP) install -r requirements.txt -r requirements-dev.txt
	$(PIP) install -e .
	@if [ -d "docs" ]; then \
		echo "Installing docs requirements..."; \
		$(PIP) install -r docs/requirements.txt; \
	fi

fix-lint: venv  ## Auto-format and fix linting/typing issues
	$(PYTHON) -m ruff format .
	$(PYTHON) -m ruff check --fix .
	$(PYTHON) -m mypy .

lint: venv  ## Audit code for linting and type safety
	$(PYTHON) -m ruff check .
	$(PYTHON) -m mypy .

test: venv  ## Run pytest with 100% coverage enforcement
	$(PYTHON) -m pytest

bump: venv  ## Increment version (usage: make bump part=patch)
	$(PYTHON) -m bump_my_version bump $(part)
	@echo "Version bumped to $$(grep '^version =' pyproject.toml | cut -d '\"' -f 2)"

release: bump  ## Setup git, bump version, and push tags (Safe for CI and Local)
ifeq ($(GITHUB_ACTIONS), true)
	@git config --global user.name "github-actions[bot]"
	@git config --global user.email "github-actions[bot]@users.noreply.github.com"
endif
	git push origin main --tags

reset-venv:  ## Wipe and recreate the virtual environment
	rm -rf $(VENV)
	$(MAKE) install-requirements

docs: venv  ## Generate HTML documentation using Sphinx
	@if [ -d "docs" ]; then \
		$(PYTHON) -m sphinx.setup_command docs; \
		$(BIN)/sphinx-build -b html docs/source docs/build; \
		echo "Docs generated at: docs/build/index.html"; \
	else \
		echo "Docs directory not found. Did you choose 'no' during project creation?"; \
	fi

update-cc:  ## Updates the project with cc that generated it
	cruft update
