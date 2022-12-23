# Boilerplate for Solidity development with Foundry

![Github Actions](https://github.com/kalaspuff/solidity-template/workflows/test/badge.svg)

*Template repo with a good base setup to get started when experimenting with smart contracts built in Solidity.* 💰

### Follows good practice to make it easy to get started

* Comes with both a simple contract and a basic contract with upgradeable functionality.
* Includes deployment scripts to easily deploy to different networks, as well as some basic unit tests.
* Sensible setup for linting with solhint and uses code style formatting from Foundry – VSCode settings for automatic code styling and warnings included.
* Includes some common libraries (such as OpenZeppelin, solmate and contracts from Safe) from the get go to make it easy to prototype.

<img width="654" alt="image" src="https://user-images.githubusercontent.com/89139/209405908-9ae22c4d-e516-402e-afbe-fc226f53045c.png">

## Get started

##### initialize your next solidity project with `forge`, using this repo as template

```bash
forge init -t kalaspuff/solidity-template your-new-project-name
# Initializing ./your-new-project-name from https://github.com/kalaspuff/solidity-template...
# Initialized forge project.
```

##### install foundry

In case you haven't installed the Solidity development toolset Foundry (`forge`, `cast` and `anvil`), tollow the installation instructions at <https://book.getfoundry.sh/getting-started/installation.html>.

In short, here's the easiest option on macOS and Linux:

```bash
# installs the foundryup shell script
curl -L https://foundry.paradigm.xyz | bash

# then use foundryup to install `forge`, `cast` and `anvil`
foundryup
```

#### Build contracts

```bash
forge build

# alternatively with make
make build
```

#### Test

```bash
forge test -vvv

# alternatively with make
make test
```

#### Linting

Requires `solhint` which can be installed with `npm install`.

```bash
npx solhint contracts/**/*.sol
forge fmt --check

# alternatively with make
make lint
```

### Deploy

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

## Additional notes

Whenever you install new libraries / dependencies using Foundry (using `foundry install`), make sure to update your `remappings.txt` file by running `forge remappings > remappings.txt`.
