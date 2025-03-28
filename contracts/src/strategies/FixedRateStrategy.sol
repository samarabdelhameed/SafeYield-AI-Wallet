// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./IYieldStrategy.sol";

contract FixedRateStrategy is IYieldStrategy {
    event StrategyDeposit(address indexed user, uint256 amount);
    event StrategyWithdraw(address indexed user, uint256 amount);

    function onDeposit(address user, uint256 amount) external override {
        emit StrategyDeposit(user, amount);
    }

    function onWithdraw(address user, uint256 amount) external override {
        emit StrategyWithdraw(user, amount);
    }
}
