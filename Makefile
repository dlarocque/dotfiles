.PHONY: help install dry-run list bootstrap update brew tpm-update lint

help: ## show this help
	@awk 'BEGIN{FS=":.*##"} /^[a-zA-Z_-]+:.*##/{printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## stow packages for the current env
	./install.sh

dry-run: ## preview what install.sh would do
	./install.sh --dry-run

list: ## list available environments
	./install.sh --list

bootstrap: ## install brews + tpm + stow (fresh machine)
	./bootstrap.sh

update: ## git pull, restow, update tmux plugins
	git pull --ff-only
	./install.sh
	$(MAKE) tpm-update

brew: ## upgrade all brews and clean up
	brew update
	brew upgrade
	brew cleanup

tpm-update: ## update tmux plugins via TPM
	@if [ -d ~/.tmux/plugins/tpm ]; then \
	  ~/.tmux/plugins/tpm/bin/update_plugins all; \
	else \
	  echo "TPM not installed; run 'make bootstrap'"; \
	fi

lint: ## shellcheck all shell scripts
	shellcheck install.sh bootstrap.sh bin/bin/*
