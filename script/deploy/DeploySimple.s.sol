// SPDX-License-Identifier: CC0-1.0

pragma solidity ^0.8.17;

import {console2 as console} from "forge-std/console2.sol";
import {DeployBase} from "./DeployBase.s.sol";
import {SimpleContract} from "contracts/SimpleContract.sol";

contract DeploySimple is DeployBase {
    address public deploymentAddress;

    function run() external {
        vm.startBroadcast(sender);
        deploymentAddress = address(new SimpleContract());
        vm.stopBroadcast();

        console.log("Deployed contract:", deploymentAddress);
    }
}
