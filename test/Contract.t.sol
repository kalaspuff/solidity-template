// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "contracts/Contract.sol";

contract ContractTest is Test {
    Contract public deployedContract;

    function setUp() public {
        deployedContract = new Contract();
    }

    function testSomething() public {
        // template
    }
}
