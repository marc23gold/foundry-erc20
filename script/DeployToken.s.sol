//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Token} from "src/Token.sol";

contract DeployToken is Script{

    uint256 public constant INITIAL_SUPPLY = 100 ether;

    function run() external returns (Token) {
        vm.startBroadcast();
        Token token = new Token(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return token;
    }
}