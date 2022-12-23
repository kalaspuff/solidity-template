# `...`

![Github Actions](https://github.com/kalaspuff/solidity-template/workflows/test/badge.svg)


## Get started

### Foundry

#### Install Foundry
Follow the installation instructions at https://book.getfoundry.sh/getting-started/installation.html.

In short, here's the easiest option on macOS and Linux:
```
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

## Notes

Whenever you install new libraries using Foundry, make sure to update your `remappings.txt` file by running `forge remappings > remappings.txt`.
