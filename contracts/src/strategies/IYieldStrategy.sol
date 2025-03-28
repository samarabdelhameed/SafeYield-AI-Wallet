// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IYieldStrategy {
    function onDeposit(address user, uint256 amount) external;

    function onWithdraw(address user, uint256 amount) external;
}
