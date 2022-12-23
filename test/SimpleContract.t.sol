// SPDX-License-Identifier: CC0-1.0

pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";
import {console2 as console} from "forge-std/console2.sol";

import {SimpleContract} from "contracts/SimpleContract.sol";

contract SimpleContractTest is Test {
    SimpleContract public deployedContract;

    function setUp() public {
        vm.startPrank(msg.sender);

        deployedContract = new SimpleContract();
    }

    /* Permissions and access control */

    function testOwner() public {
        assertEq(deployedContract.owner(), msg.sender);
    }

    /* Gas tests */

    function testGasDeploy() public {
        new SimpleContract();
    }
}
