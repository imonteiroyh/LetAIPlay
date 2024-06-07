.PHONY: help
help:				## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets: "
	@fgrep "##" Makefile | fgrep -v fgrep


.PHONY: clean
clean:				## Clean unused files.
	@echo "Cleaning up..."
	@find . -name "*.pyc" -exec rm -rf {} +
	@find . -name "__pycache__" -exec rm -rf {} +
	@rm -rf .mypy_cache
	@rm -rf .pytest_cache


.PHONY: install
install: clean		## Install.
	@if [ "$(DEV)" = "1" ]; then \
		pip install -r requirements_development.txt; \
	fi

	@echo "Installing with test dependencies only by default..."
	@echo "To include development dependencies, use: make install DEV=1"
	@pip install -r requirements.txt


.PHONY: format
format:				## Format code using isort and black
	isort --settings-path setup.cfg .
	black -l 110 .


.PHONY: lint
lint:				## Run linters
	flake8 --config setup.cfg .
	black -l 110 --check .
	mypy --config-file setup.cfg .
