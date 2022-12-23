// SPDX-License-Identifier: CC0-1.0

pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";
import {console2 as console} from "forge-std/console2.sol";

import {ERC1967Proxy} from "contracts/proxy/ERC1967Proxy.sol";
import {UpgradeableContract} from "contracts/UpgradeableContract.sol";

contract UpgradeableContractTest is Test {
    UpgradeableContract public deployedContract;

    function setUp() public {
        vm.startPrank(msg.sender);

        bytes memory initData = abi.encodeWithSignature("initialize(address)", address(msg.sender));
        deployedContract = UpgradeableContract(address(new ERC1967Proxy(address(new UpgradeableContract()), initData)));
    }

    /* Permissions and access control */

    function testOwner() public {
        assertEq(deployedContract.owner(), msg.sender);
    }

    function testUpgraderRole() public {
        assertTrue(deployedContract.hasRole(deployedContract.UPGRADER_ROLE(), msg.sender));
    }

    /* Gas tests */

    function testGasDeployImplementation() public {
        new UpgradeableContract();
    }

    function testGasDeployInitial() public {
        bytes memory initData = abi.encodeWithSignature("initialize(address)", address(msg.sender));
        new ERC1967Proxy(address(new UpgradeableContract()), initData);
    }

    function testGasUpgrade() public {
        deployedContract.upgradeTo(address(new UpgradeableContract()));
    }
}
