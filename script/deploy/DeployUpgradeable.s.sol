// SPDX-License-Identifier: CC0-1.0

pragma solidity ^0.8.17;

import {console2 as console} from "forge-std/console2.sol";
import {DeployBase} from "./DeployBase.s.sol";
import {ERC1967Proxy} from "contracts/proxy/ERC1967Proxy.sol";
import {UpgradeableContract} from "contracts/UpgradeableContract.sol";

contract DeployUpgradeable is DeployBase {
    address public implementationAddress;
    address public deploymentAddress;

    function run() external {
        vm.startBroadcast(sender);
        implementationAddress = address(new UpgradeableContract());
        deploymentAddress =
            address(new ERC1967Proxy(implementationAddress, abi.encodeWithSignature("initialize(address)", sender)));
        vm.stopBroadcast();

        console.log("Deployed implementation:", implementationAddress);
        console.log("Deployed ERC1967 proxy:", deploymentAddress);
    }
}
