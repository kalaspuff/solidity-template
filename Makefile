ifndef VERBOSE
.SILENT:
endif

THIS_FILE := $(lastword $(MAKEFILE_LIST))

define shell-functions
: BEGIN
runcmd() {
	_cmd=$@;
	printf "\e[90;1m[\e[032;1mmake \e[90;1m➔ \e[033;1mcmd\e[90;1m]\e[0m ≡ \e[90m$_cmd\e[0m\n" \
		&& ( \
			cmd_output=$(script -q /dev/null $_cmd >&1 | tee /dev/tty; exit ${PIPESTATUS[0]}); cmd_exit_code=$?; \
			[ -z "$cmd_output" ] || ([ -z "$(tr -d '[:space:]' <<< $cmd_output)" ] && printf "\e[1A"); \
			[[ "$cmd_exit_code" -eq 0 ]] || return $cmd_exit_code \
		) \
		&& printf "\e[032;1m[✔︎] success\e[0m\n\n" \
			|| (_test_exit=$? \
				&& printf "\e[031;1m[✖︎] fail (exit code: $_test_exit)\e[0m\n\n" \
				&& return $_test_exit) \
			&& [ $? -eq 0 ] \
				|| return $?
}
: END
endef

$(shell sed -n '/^: BEGIN/,/^: END/p' $(THIS_FILE) > .make.functions.sh)
SHELL := /bin/bash --init-file .make.functions.sh -i

default:
	@echo "Usage:"
	@echo "- make build        | build contracts"
	@echo "- make test         | run unit tests"
	@echo "- make lint         | lint code"
	@echo "- make fmt          | apply code style formatting"

.PHONY: forge-build
forge-build:
	@runcmd forge build

.PHONY: forge-test
forge-test:
	@runcmd forge test -vvv

.PHONY: forge-lint
forge-lint:
	@runcmd forge fmt --check

.PHONY: solhint-lint
solhint-lint:
	@runcmd npx solhint 'contracts/**/*.sol'

.PHONY: forge-fmt
forge-fmt:
	@runcmd forge fmt

build: forge-build
contract: build
contracts: build

test: forge-test
tests: test

lint: solhint-lint forge-lint
linting: lint
linter: lint

fmt: forge-fmt
format: fmt
formatting: fmt
