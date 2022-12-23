// SPDX-License-Identifier: CC0-1.0

pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {console2 as console} from "forge-std/console2.sol";

// Default address for msg.sender: 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
address constant DEFAULT_SENDER = address(uint160(uint256(keccak256("foundry default caller"))));
address constant FALLBACK_SENDER = 0x00000000C0DE4711C0dE4711C0de471100000000;

abstract contract DeployBase is Script {
    address public sender;

    function getChainId() public view returns (uint256) {
        return block.chainid > 0 ? block.chainid : 31337;
    }

    function setUp() public {
        console.log("Chain ID | block.chainid:", getChainId());

        uint256 privateKey = vm.envOr("DEPLOYER_PRIVATE_KEY", uint256(0));
        try vm.envOr("DEPLOYER_SENDER", address(0)) returns (address _sender) {
            sender = _sender;
        } catch {
            if (vm.envBytes("DEPLOYER_SENDER").length > 0) {
                revert("Invalid DEPLOYER_SENDER value");
            }
            sender = address(0);
        }

        if (msg.sender != DEFAULT_SENDER && msg.sender != sender) {
            sender = msg.sender;
            privateKey = 0;
            console.log("Overriding DEPLOYER_SENDER with msg.sender | msg.sender:", sender);
        } else if (msg.sender == DEFAULT_SENDER && sender == address(0) && privateKey == 0) {
            sender = FALLBACK_SENDER;
            console.log("Overriding DEPLOYER_SENDER with default sender | msg.sender:", sender);
        }

        if (privateKey != 0) {
            if (sender == address(0)) {
                sender = vm.addr(privateKey);
                console.log("Using sender derived from private key | msg.sender:", sender);
            } else if (vm.addr(privateKey) != sender) {
                revert("Invalid sender for private key");
            } else {
                console.log("Using sender for matching private key | msg.sender:", sender);
            }
        } else {
            console.log("Using sender without access to private key | msg.sender:", sender);
        }
    }
}
