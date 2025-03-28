// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/AuthenticationManager.sol";

contract AuthenticationManagerTest is Test {
    AuthenticationManager public auth;

    function setUp() public {
        auth = new AuthenticationManager();
    }

    function testRegisterAndLogin() public {
        address user = address(0xBEEF);
        bytes32 verifier = keccak256("valid-passkey");

        vm.prank(user);
        auth.register(verifier);

        bool isAuthenticated = auth.login(user, verifier);
        assertTrue(isAuthenticated);
    }

    function testDoubleRegisterShouldFail() public {
        address user = address(0xBEEF);
        bytes32 verifier1 = keccak256("valid-passkey");
        bytes32 verifier2 = keccak256("another-passkey");

        vm.prank(user);
        auth.register(verifier1);

        vm.prank(user);
        vm.expectRevert("Already registered");
        auth.register(verifier2);
    }
}
