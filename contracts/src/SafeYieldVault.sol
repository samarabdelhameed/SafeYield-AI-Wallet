// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SafeYieldVault {
    mapping(address => uint256) public balances;
    uint256 public totalDeposits;

    // Event for deposit and withdrawal
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Deposit function
    function deposit(uint256 amount) external {
        balances[msg.sender] += amount;
        totalDeposits += amount;
        emit Deposited(msg.sender, amount);
    }

    // Withdraw function
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        totalDeposits -= amount;
        emit Withdrawn(msg.sender, amount);
    }

    // Function to calculate yield (simplified for now)
    function calculateYield(address user) external view returns (uint256) {
        uint256 userBalance = balances[user];
        return (userBalance * 10) / 100; // 10% yield
    }
}
