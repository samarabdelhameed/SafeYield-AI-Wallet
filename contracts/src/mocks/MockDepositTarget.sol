// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MockDepositTarget {
    event Deposited(uint256 amount);

    function deposit(uint256 amount) external {
        emit Deposited(amount);
    }
}
