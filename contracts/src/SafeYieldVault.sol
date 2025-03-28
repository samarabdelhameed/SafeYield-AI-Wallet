// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./strategies/IYieldStrategy.sol";

contract SafeYieldVault is ReentrancyGuard {
    IERC20 public immutable token;
    IYieldStrategy public strategy;

    uint256 public constant YEAR = 365 days;
    uint256 public constant RATE = 10;

    mapping(address => uint256) public balances;
    mapping(address => uint256) public lastClaimed;

    uint256 public totalDeposits;

    // ✅ Custom Errors
    error AmountMustBeGreaterThanZero();
    error InsufficientBalance();
    error TransferFailed();

    // ✅ Events
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event YieldClaimed(address indexed user, uint256 yieldAmount);

    constructor(address _token, address _strategy) {
        token = IERC20(_token);
        strategy = IYieldStrategy(_strategy);
    }

    function deposit(uint256 amount) external nonReentrant {
        if (amount == 0) revert AmountMustBeGreaterThanZero();

        _claimYield(msg.sender);

        if (!token.transferFrom(msg.sender, address(this), amount)) {
            revert TransferFailed();
        }

        balances[msg.sender] += amount;
        totalDeposits += amount;

        if (lastClaimed[msg.sender] == 0) {
            lastClaimed[msg.sender] = block.timestamp;
        }

        strategy.onDeposit(msg.sender, amount);
        emit Deposited(msg.sender, amount);
    }

    function withdraw(uint256 amount) external nonReentrant {
        if (balances[msg.sender] < amount) revert InsufficientBalance();

        _claimYield(msg.sender);

        balances[msg.sender] -= amount;
        totalDeposits -= amount;

        if (!token.transfer(msg.sender, amount)) {
            revert TransferFailed();
        }

        strategy.onWithdraw(msg.sender, amount);
        emit Withdrawn(msg.sender, amount);
    }

    function claimYield() external nonReentrant {
        _claimYield(msg.sender);
    }

    function _claimYield(address user) internal {
        uint256 pending = calculatePendingYield(user);
        if (pending > 0) {
            if (!token.transfer(user, pending)) {
                revert TransferFailed();
            }
            lastClaimed[user] = block.timestamp;
            emit YieldClaimed(user, pending);
        }
    }

    function calculatePendingYield(address user) public view returns (uint256) {
        uint256 balance = balances[user];
        if (balance == 0 || lastClaimed[user] == 0) return 0;

        uint256 timePassed = block.timestamp - lastClaimed[user];
        return (balance * timePassed * RATE) / (YEAR * 100);
    }

    function calculateYield(address user) external view returns (uint256) {
        return calculatePendingYield(user);
    }
}
