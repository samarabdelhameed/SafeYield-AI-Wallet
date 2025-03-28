// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/SafeYieldVault.sol";

contract SafeYieldVaultTest is Test {
    SafeYieldVault public vault;
    address public user = address(0xBEEF);
    uint256 public depositAmount = 1000;

    function setUp() public {
        vault = new SafeYieldVault();
    }

    // Test deposit functionality
    function testDeposit() public {
        vm.prank(user);
        vault.deposit(depositAmount);

        uint256 balance = vault.balances(user);
        assertEq(balance, depositAmount, "Deposit failed, balance mismatch");
    }

    // Test withdraw functionality
    function testWithdraw() public {
        vm.prank(user);
        vault.deposit(depositAmount);

        // Withdraw
        vm.prank(user);
        vault.withdraw(depositAmount);

        uint256 balance = vault.balances(user);
        assertEq(balance, 0, "Withdraw failed, balance mismatch");
    }

    // Test yield calculation
    function testCalculateYield() public {
        vm.prank(user);
        vault.deposit(depositAmount);

        uint256 yield = vault.calculateYield(user);
        uint256 expectedYield = (depositAmount * 10) / 100; // 10% yield
        assertEq(yield, expectedYield, "Yield calculation is incorrect");
    }

    // Test withdrawal with insufficient balance
    function testWithdrawInsufficientBalance() public {
        vm.prank(user);
        vault.deposit(depositAmount);

        // Attempt to withdraw more than deposited
        vm.prank(user);
        vm.expectRevert("Insufficient balance");
        vault.withdraw(depositAmount + 1);
    }
}
