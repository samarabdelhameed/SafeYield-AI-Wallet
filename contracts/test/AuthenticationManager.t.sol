// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/AuthenticationManager.sol";

contract AuthenticationManagerTest is Test {
    AuthenticationManager auth;

    function setUp() public {
        auth = new AuthenticationManager();
    }

    function testRegisterAndLogin() public {
        address user = address(0xBEEF);
        bytes32 verifier = keccak256("secret-passkey");

        vm.prank(user);
        auth.register(verifier);

        vm.prank(user);
        bool isAuthenticated = auth.login(verifier);
        assertTrue(isAuthenticated);
    }

    function testDoubleRegisterShouldFail() public {
        address user = address(0xCAFE);
        bytes32 verifier = keccak256("first");
        bytes32 secondVerifier = keccak256("second");

        vm.prank(user);
        auth.register(verifier);

        vm.prank(user);
        vm.expectRevert("Already registered");
        auth.register(secondVerifier);
    }
}
