//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployToken} from "script/DeployToken.s.sol";
import {Token} from "src/Token.sol";

contract TokenTest is Test{

    Token public token;
    DeployToken public deployer;

    address USER = makeAddr("user");
    address ALICE = makeAddr("alice");

    uint256 public constant INITIAL_SUPPLY = 10 ether;

    function setUp() public {
        DeployToken deployer = new DeployToken();
        token = deployer.run();

        vm.prank(address(msg.sender));
        token.transfer(USER, INITIAL_SUPPLY);
    }

    function testUserBalance() public {
        assertEq(INITIAL_SUPPLY, token.balanceOf(USER));
    }

    function testAllowancesWorks() public {
        uint256 initalAllownace = 1000;
        vm.prank(USER);
        token.approve(ALICE, initalAllownace); 

        uint256 transferAmount = 500;

        vm.prank(ALICE);
        token.transferFrom(USER, ALICE, transferAmount);

        assertEq(transferAmount, token.balanceOf(ALICE));
        assertEq(token.balanceOf(USER), INITIAL_SUPPLY - transferAmount);   
    }

}