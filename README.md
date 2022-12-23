# Boilerplate for Solidity development with Foundry

![Github Actions](https://github.com/kalaspuff/solidity-template/workflows/test/badge.svg)

*Template repo with a good base setup to get started when experimenting with smart contracts built in Solidity.* 💰

### Follows good practice to make it easy to get started

* Comes with both a simple contract and a basic contract with upgradeable functionality.
* Includes deployment scripts to easily deploy to different networks, as well as some basic unit tests.
* Sensible setup for linting with solhint and uses code style formatting from Foundry – VSCode settings for automatic code styling and warnings included.
* Includes some common libraries (such as OpenZeppelin, solmate and contracts from Safe) from the get go to make it easy to prototype.

```bash
# initialize your next solidity project with: forge init -t kalaspuff/solidity-template
forge init -t kalaspuff/solidity-template your-new-project-name
```

## Get started

### Foundry

#### Install Foundry

Follow the installation instructions at <https://book.getfoundry.sh/getting-started/installation.html>.

In short, here's the easiest option on macOS and Linux:

```bash
# installs the foundryup shell script
curl -L https://foundry.paradigm.xyz | bash

# then use foundryup to install `forge`, `cast` and `anvil`
foundryup
```

#### Install dependencies

```bash
forge install
```

#### Build contracts

```bash
forge build
```

#### Test

```bash
forge test
```

#### Deploy

##### `UpgradeableContract.sol`

```bash
# specify private key in .env as DEPLOYER_PRIVATE_KEY
FOUNDRY_PROFILE=goerli forge script script/deploy/DeployUpgradeable.s.sol -vvvv

# deployment with ledger wallet
FOUNDRY_PROFILE=goerli FOUNDRY_SENDER=0x39bEb60bc4c1b8b0eBeEDC515c7A56e7DfB3a5A9 forge script script/deploy/DeployUpgradeable.s.sol -vvvv -l
```

##### `SimpleContract.sol`

```bash
# specify private key in .env as DEPLOYER_PRIVATE_KEY
FOUNDRY_PROFILE=goerli forge script script/deploy/DeploySimple.s.sol -vvvv

# deployment with ledger wallet
FOUNDRY_PROFILE=goerli FOUNDRY_SENDER=0x39bEb60bc4c1b8b0eBeEDC515c7A56e7DfB3a5A9 forge script script/deploy/DeploySimple.s.sol -vvvv -l
```

## Notes

Whenever you install new libraries using Foundry, make sure to update your `remappings.txt` file by running `forge remappings > remappings.txt`.
