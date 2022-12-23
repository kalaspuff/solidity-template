// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.17;

import {Script as FoundryScript} from "forge-std/Script.sol";

contract Script is FoundryScript {
    function setUp() public {}

    function run() public {
        vm.broadcast();
    }
}
