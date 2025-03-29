// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {UserOperation} from "./lib/UserOperation.sol";

/// @dev Minimal interface for EntryPoint
interface IEntryPoint {
    // Placeholder interface for EIP-4337 compatibility
}

/// @title IntentExecutor
/// @notice Executes user operations coming from intents (EIP-4337 style)
contract IntentExecutor {
    IEntryPoint public entryPoint;

    event OperationExecuted(address indexed wallet, bytes4 indexed selector);

    constructor(address _entryPoint) {
        entryPoint = IEntryPoint(_entryPoint);
    }

    /// @notice Execute a UserOperation on behalf of a wallet
    /// @param userOp The UserOperation struct generated from AI/intent
    function execute(UserOperation calldata userOp) external {
        require(msg.sender == address(entryPoint), "Not EntryPoint");

        // Execute the user operation
        (bool success, ) = userOp.sender.call(userOp.callData);
        require(success, "Execution failed");

        // Extract the selector manually (first 4 bytes of callData)
        bytes4 selector;
        if (userOp.callData.length >= 4) {
            selector = bytes4(
                userOp.callData[0] |
                    (bytes4(userOp.callData[1]) >> 8) |
                    (bytes4(userOp.callData[2]) >> 16) |
                    (bytes4(userOp.callData[3]) >> 24)
            );
        }

        emit OperationExecuted(userOp.sender, selector);
    }
}
