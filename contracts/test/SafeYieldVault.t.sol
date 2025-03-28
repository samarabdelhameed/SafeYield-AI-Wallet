// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/SafeYieldVault.sol";
import "../src/mocks/MockERC20.sol";
import "../src/strategies/FixedRateStrategy.sol";

contract SafeYieldVaultTest is Test {
    SafeYieldVault vault;
    MockERC20 token;
    FixedRateStrategy strategy;
    address user = address(0x1);

    function setUp() public {
        token = new MockERC20("Test Token", "TT");
        strategy = new FixedRateStrategy();
        vault = new SafeYieldVault(address(token), address(strategy));

        token.mint(user, 1e21); // 1000 tokens

        vm.prank(user);
        token.approve(address(vault), type(uint256).max);
    }

    function testDeposit() public {
        vm.prank(user);
        vault.deposit(500e18);

        assertEq(vault.balances(user), 500e18);
        assertEq(vault.totalDeposits(), 500e18);
    }

    function testWithdraw() public {
        vm.startPrank(user);
        vault.deposit(800e18);
        vault.withdraw(300e18);
        vm.stopPrank();

        assertEq(vault.balances(user), 500e18);
        assertEq(vault.totalDeposits(), 500e18);
    }

    function testRevertZeroDeposit() public {
        vm.prank(user);
        vm.expectRevert(SafeYieldVault.AmountMustBeGreaterThanZero.selector);
        vault.deposit(0);
    }

    function testRevertWithdrawTooMuch() public {
        vm.prank(user);
        vault.deposit(100e18);

        vm.prank(user);
        vm.expectRevert(SafeYieldVault.InsufficientBalance.selector);
        vault.withdraw(200e18);
    }

    function testYieldCalculationAfterTime() public {
        vm.prank(user);
        vault.deposit(100e18);

        // simulate 1 year
        vm.warp(block.timestamp + 365 days);

        uint256 expected = 10e18;
        uint256 pending = vault.calculatePendingYield(user);

        assertApproxEqAbs(pending, expected, 1e15); // allow 0.001 diff
    }

    function testYieldIsZeroAfterClaim() public {
        vm.startPrank(user);
        vault.deposit(100e18);

        vm.warp(block.timestamp + 365 days);
        vault.claimYield();

        uint256 pending = vault.calculatePendingYield(user);
        assertEq(pending, 0);

        vm.stopPrank();
    }

    function testClaimYield() public {
        vm.startPrank(user);
        vault.deposit(100e18);

        vm.warp(block.timestamp + 365 days);
        vault.claimYield();

        uint256 balance = token.balanceOf(user);
        assertApproxEqAbs(balance, 910e18, 2e17); // user: 1000 - 100 + 10 = 910 ± 0.2
        vm.stopPrank();
    }

    function testAutoClaimInDeposit() public {
        vm.startPrank(user);
        vault.deposit(100e18);

        vm.warp(block.timestamp + 365 days);

        uint256 balanceBefore = token.balanceOf(user);
        vault.deposit(100e18);
        uint256 balanceAfter = token.balanceOf(user);

        // balance should decrease by 100 (deposit) and increase by 10 (claim)
        uint256 expected = balanceBefore - 90e18;
        assertApproxEqAbs(balanceAfter, expected, 1e17); // ~0.1 diff allowed
        vm.stopPrank();
    }

    function testAutoClaimInWithdraw() public {
        vm.startPrank(user);
        vault.deposit(100e18);

        vm.warp(block.timestamp + 365 days);
        vault.withdraw(50e18);

        uint256 balance = token.balanceOf(user);
        // initial = 1000 - 100 = 900
        // claim yield = 10
        // withdraw = 50
        // 900 + 10 + 50 = 960
        assertApproxEqAbs(balance, 960e18, 2e17); // ± 0.2
        vm.stopPrank();
    }
}
