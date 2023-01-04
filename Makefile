.SILENT:

THIS_FILE := $(lastword $(MAKEFILE_LIST))

define shell-functions
: BEGIN
runcmd() {
	_cmd=$@;

	script_cmd="script -q /dev/null ${_cmd[@]} >&1";
	script -q /dev/null -c echo 2> /dev/null > /dev/null && script_cmd="script -q /dev/null -c \"${_cmd[@]}\" >&1";

	printf "\e[90;1m[\e[90;1mmake: \e[0;90;1mcmd\e[0;90;1m]\e[0m \e[0;93;1m➔ \e[97;1m$_cmd\e[0m\n" \
		&& ( \
			cmd_output=$(eval "$script_cmd" | tee /dev/tty; exit ${PIPESTATUS[0]}); cmd_exit_code=$?; \
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
	printf """\e[37musage:\e[0m\n \
		  \e[90m$$ \e[0;97;1mmake \e[0;92;1mbuild         \e[0;90m➔ \e[32;3mbuild contracts \e[0m\n \
		  \e[90m$$ \e[0;97;1mmake \e[0;92;1mtest          \e[0;90m➔ \e[32;3mrun unit tests \e[0m\n \
		  \e[90m$$ \e[0;97;1mmake \e[0;92;1mlint          \e[0;90m➔ \e[32;3mlint code \e[0m\n \
		  \e[90m$$ \e[0;97;1mmake \e[0;92;1minstall       \e[0;90m➔ \e[32;3minstall dependencies \e[0m\n \
		  \e[90m$$ \e[0;97;1mmake \e[0;92;1mformat        \e[0;90m➔ \e[32;3mapply code style formatting \e[0m\n \
		  \e[90m$$ \e[0;97;1mmake \e[0;92;1mclean         \e[0;90m➔ \e[32;3mremove build artifacts \e[0m\n \
	""" | sed -e 's/^[  \t]\{1,\}\(.\)/  \1/'

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
	@runcmd npx solhint \'contracts/**/*.sol\'

.PHONY: forge-fmt
forge-fmt:
	@runcmd forge fmt

.PHONY: forge-clean
forge-clean:
	@runcmd forge clean

.PHONY: foundryup-install
foundryup-install:
	@runcmd foundryup

.PHONY: npm-install
npm-install:
	@runcmd npm install

.PHONY: git-submodule-update
git-submodule-update:
	@runcmd git submodule update --init --recursive

.PHONY: dotenv-setup
dotenv-setup:
	@runcmd "[ -e .env ] || cp .env.example .env"

build: forge-build
contract: build
contracts: build

test: forge-test
tests: test

lint: solhint-lint forge-lint
linting: lint
linter: lint

format: forge-fmt
fmt: format
formatting: format

clean: forge-clean

install: git-submodule-update npm-install dotenv-setup
