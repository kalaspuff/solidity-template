# `≡ solidity-template`

*This is a boilerplate repo providing a base setup to get started experimenting with smart contracts built in Solidity. This template should preferably be used with the [Foundry toolkit](https://github.com/foundry-rs/foundry). The setup is mostly tested on macOS.*

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=master&repo=581580533)

### Smart Contract Development in Solidity for Ethereum

* ✨ Developer experience improvements using good defaults and with the goal to follow best practices.
* 🪢 Comes with both a simple example contract and a more complex upgradeable contract + ERC1967 proxy.
* 🚀 Includes deployment scripts to easily deploy to different networks, as well as some basic unit tests.
* 🪄 Sensible setup for linting, code formatting — includes VSCode settings for auto code style, etc.
* 📚 Includes some common libraries (such as OpenZeppelin, solmate and contracts from Safe).
* 🎉 Aims to make it easy for devs to prototype and code contracts without the effort of the initial chores.

### Contributions

If you find any bugs 🐛 in the contracts, in this documentation or if you have ideas 💡 of ways to make this more useful and dev friendly – please open an issue or PR on GitHub [`➔ kalaspuff/solidity-template`](https://github.com/kalaspuff/solidity-template). 🙏

## Get started

These instructions expect you to be running a Linux or macOS system with Foundry and build essentials already installed. This *might* also work on another setup (such as WSL or other shells) where you can use environment values + use the Foundry CLI (eventually USB permissions also required in case you need to access a USB connected cold wallet).

### 🏃 ⌁ Initialize and install dependencies

Initialize a project with `forge init -t kalaspuff/solidity-template` to use this repo as template.

```console
user@cpu:~/code $ forge init -t kalaspuff/solidity-template my-contract
Initializing ./my-contract from https://github.com/kalaspuff/solidity-template...
Initialized forge project.
```

The new project will be initialized at the given name (in the above example `my-contract`).

```console
user@cpu:~/code $ cd my-contract
user@cpu:~/code/my-contract $
```

Populate the `.env` with the `.env.example` data (which includes some free RPC nodes from Ankr).

```console
user@cpu:~/code/my-contract $ cp .env.example .env
```

The linter `solhint` is installed via `npm`

```console
user@cpu:~/code/my-contract $ npm install
```

### 🔗 ⌁ Update the remote origin

After you've initialized your project with `forge init` you need to change remote repository to be able to push commits towards your own repo.

##### Change the remote url to for example `coder/my-contract` (on GitHub)

```console
user@cpu:~/code/my-contract $ git remote set-url origin https://github.com/coder/my-contract.git
user@cpu:~/code/my-contract $ git remote -v
origin https://github.com/coder/my-contract (fetch)
origin https://github.com/coder/my-contract (push)
```

## Development

A couple of `make` commands are available for convenience and quality of life.

```console
user@cpu:~/code/my-contract $ make
usage:
  $ make build         ➔ build contracts
  $ make test          ➔ run unit tests
  $ make lint          ➔ lint code
  $ make install       ➔ install dependencies
  $ make format        ➔ apply code style formatting
  $ make clean         ➔ remove build artifacts
```

#### Explore Foundry if you haven't already. 💻

* Highly recommended to become used to the CLI tools from Foundry – specially `forge` and `cast`.
* Start with checking out the help output from `forge --help` and `cast --help`.
* There's also additional information to read up on at <https://book.getfoundry.sh/>.

### 🚧 ⌁ Build contracts

Build the contracts using `make build` or `forge build`.

```console
user@cpu:~/code/my-contract $ make build
[make: cmd] ➔ forge build
[⠊] Compiling...
[⠘] Solc 0.8.17 finished
Compiler run successful
```

### 👌 ⌁ Linting and code styling

If you're a VSCode user with the Solidity extension installed you'll get all the linting and automated code formatting you need from within VSCode.

For all other linting needs – run lint checks with `make lint` or manually with `solhint` and `forge fmt --check`.

```console
user@cpu:~/code/my-contract $ make lint
[make: cmd] ➔ npx solhint contracts/**/*.sol
[make: cmd] ➔ forge fmt --check
```

### 🧪 ⌁ Test cases implemented in Solidity

Run the Solidity tests that lives in the [`./test`](test/) folder with `make test` or `forge test`.

```console
user@cpu:~/code/my-contract $ make test
[make: cmd] ➔ forge test
Running 2 tests for test/SimpleContract.t.sol:SimpleContractTest            ✔︎✔︎
Running 5 tests for test/UpgradeableContract.t.sol:UpgradeableContractTest  ✔︎✔︎✔︎✔︎✔︎
```

## Installation of Foundry

In case you haven't installed the Solidity development toolset **Foundry** (`forge`, `cast` and `anvil`), follow the installation instructions at <https://book.getfoundry.sh/getting-started/installation.html>.

In short, here's the easiest option on Linux and macOS.

##### Install the `foundryup` shell script, followed by installation of `forge`, `cast` and `anvil`

```console
user@cpu:~ $ curl -L https://foundry.paradigm.xyz | bash
Installing foundryup...
```

When installing `foundryup`, the PATH to where Foundry is located is added to your shell's profile file. Follow the instructions that's shown of how to reinitialize your shell (usually `source ~/.zshrc` or `source ~/.bashrc`).

##### Use `foundryup` to complete the installion of `forge`, `cast` and `anvil`

```console
user@cpu:~ $ foundryup
foundryup: installing foundry (version nightly, tag nightly)
foundryup: done
```

## The `.env` file and environment values

Set up your credentials required for deployments (for testnets + mainnet or other EVM chains), together with API keys for etherscan, etc. to automate the verification part during deployments. The `.env` file is ofc. ignored using `.gitignore` so that it isn't accidentally committed to a Git repo.

### 🔒 ⌁ Example of `.env` configuration values

The default `.env.example` file comes with a few examples of of values, but you usually will only need to specify a few of them - here's an example for set up where we want to test on Goerli and later deploy to Ethereum mainnet:

```env
# the private key of the eoa address you want to initiate deploy scripts from
DEPLOYER_PRIVATE_KEY="0x0000000000000000000000000000000000000000000000000000000000000000"

# for goerli and mainnet we'll often use the same etherscan api key
MAINNET_ETHERSCAN_API_KEY="000000000000ETHERSCANAPIKEYEXAMPLE"
GOERLI_ETHERSCAN_API_KEY="000000000000ETHERSCANAPIKEYEXAMPLE"

# any rpc url of your choice or for example rpc urls provided from alchemy, ankr, etc.
MAINNET_RPC_URL="https://rpc.ankr.com/eth"
GOERLI_RPC_URL="https://rpc.ankr.com/eth_goerli"
```

## Deployment

<sub>DISCLAIMER</sub>

* 🧑‍🔬 Code in this repo may be experimental.
* 🐛 Code may not function in your intended way.
* 🚨 Know what you're doing.
* 💸 Use at your own risk.

A few examples of how the provided example contracts could be deployed and verified on Etherscan. Please understand the disclaimer above so you don't accidentally end up losing your precious ETH.

### 🚀 ⌁ Deployment script for flexible or complex deployments

Deployment by running a Solidity script + verification of all deployed contracts during broadcast.

* [`➔ contracts/SimpleContract.sol`](contracts/SimpleContract.sol)

  * Deployment using the `DEPLOYER_PRIVATE_KEY` which you can specify in your `.env`.

    ```bash
    FOUNDRY_PROFILE="goerli" \
    forge script script/deploy/DeploySimple.s.sol -vvvv --verify --broadcast
    ```

  * Deployment with a Ledger wallet (use your address as env value to `FOUNDRY_SENDER`).

    ```bash
    FOUNDRY_PROFILE="goerli" \
    FOUNDRY_SENDER="0x39bEb60bc4c1b8b0eBeEDC515c7A56e7DfB3a5A9" \
    forge script script/deploy/DeploySimple.s.sol -vvvv --verify --broadcast -l
    ```

* [`➔ contracts/UpgradeableContract.sol`](contracts/UpgradeableContract.sol)<br/>[`➔ contracts/proxy/ERC1967Proxy.sol`](contracts/proxy/ERC1967Proxy.sol)

  * Deployment using the `DEPLOYER_PRIVATE_KEY` which you can specify in your `.env`.

    ```bash
    FOUNDRY_PROFILE="goerli" \
    forge script script/deploy/DeployUpgradeable.s.sol -vvvv --verify --broadcast
    ```

  * Deployment with a Ledger wallet (use your address as env value to `FOUNDRY_SENDER`).

    ```bash
    FOUNDRY_PROFILE="goerli" \
    FOUNDRY_SENDER="0x39bEb60bc4c1b8b0eBeEDC515c7A56e7DfB3a5A9" \
    forge script script/deploy/DeployUpgradeable.s.sol -vvvv --verify --broadcast -l
    ```

### 🦄 ⌁ Alternative deployment for simpler contracts

This method instead deploys the contract using `forge create`.

This method is most likely only suitable for simpler contracts or contracts that doesn't require any dynamic arguments for their constructor.

* [`➔ contracts/SimpleContract.sol`](contracts/SimpleContract.sol)

  * Deploying using `forge create` (specify the private key for the address to deploy from).

    ```bash
    FOUNDRY_PROFILE="goerli" \
    forge create --verify --private-key "PRIVATE KEY HERE" \
        contracts/SimpleContract.sol:SimpleContract
    ```

  * Deploying using `forge create` with a Ledger (`FOUNDRY_SENDER` value should be your address).

    ```bash
    FOUNDRY_PROFILE="goerli" \
    FOUNDRY_SENDER="0x39bEb60bc4c1b8b0eBeEDC515c7A56e7DfB3a5A9" \
    forge create --verify -l \
        contracts/SimpleContract.sol:SimpleContract
    ```

### 📒 ⌁ Etherscan verification for previously unverified contracts

Usually the contract should be verified during deployment if a correct API key for Etherscan is given and if the deployment was done together with the `--verify` option.

This is only needed to manually verify contracts that weren't verified during their deployment.

* [`➔ contracts/SimpleContract.sol`](contracts/SimpleContract.sol)

  * Verify contract (specify the actual contract address instead of `"CONTRACT ADDRESS"`).

    ```bash
    forge verify-contract \
        --chain "goerli" \
        --watch \
        "CONTRACT ADDRESS" \
        --constructor-args $(cast abi-encode "constructor()") \
        contracts/SimpleContract.sol:SimpleContract
    ```

* [`➔ contracts/UpgradeableContract.sol`](contracts/UpgradeableContract.sol)<br/>[`➔ contracts/proxy/ERC1967Proxy.sol`](contracts/proxy/ERC1967Proxy.sol)

  The upgradeable contract has an implementation contract as well as a proxy contract that needs verification. Replace the values for `"IMPLEMENTATION ADDRESS"`, `"PROXY ADDRESS"` and `"DEPLOYER ADDRESS"` in the examples below.

  * Verification of the implementation contract and the proxy contract.

    ```bash
    forge verify-contract \
        --chain "goerli" \
        --watch \
        "IMPLEMENTATION ADDRESS" \
        --constructor-args $(cast abi-encode "constructor()") \
        contracts/UpgradeableContract.sol:UpgradeableContract
    ```

    ```bash
    forge verify-contract \
        --chain "goerli" \
        --watch \
        "PROXY ADDRESS" \
        --constructor-args \
            $(cast abi-encode \
                "constructor(address,bytes)" \
                "IMPLEMENTATION ADDRESS" \
                $(cast abi-encode "initialize(address)" "DEPLOYER ADDRESS") \
            ) \
        contracts/proxy/ERC1967Proxy.sol:ERC1967Proxy
    ```

## Adding and removing dependencies

🧭 Whenever you install new libraries / dependencies using Foundry (using `foundry install`), make sure to update your `remappings.txt` file by running `forge remappings > remappings.txt`.

✂️ This boilerplate template includes a few different libs which you most likely won't need. Feel free to remove them from your setup – for example `forge remove safe-contracts` to remove the `safe-contracts` library.

## Opinions and feedback

We're all learning. Feedback and contributions most welcome!

### 💬 ⌁ Contact info

* 🎉 If you think this is 🌟🤩🌹🪄🌈 and want to connect — shoot me a message and say hi. 👋<br/>
* 🤬 If you think this is 💩🐛💥🙅👎 and want to help out — shoot me a message and say hi. 🙏

```
twitter ◼️ https://twitter.com/carloscaraaro
coa.eth ◼️ 0x39bEb60bc4c1b8b0eBeEDC515c7A56e7DfB3a5A9
discord ◼️ carloscar#0001
void    ◼️ hello@carloscar.com
```

<sup>**If we're not already friends on the internet, the risk is high that I'll miss your message.**</sub>
