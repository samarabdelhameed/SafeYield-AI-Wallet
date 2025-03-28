// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SafeYieldWallet} from "./SafeYieldWallet.sol";
import {UserOperation} from "account-abstraction/interfaces/UserOperation.sol";
import {IEntryPoint} from "account-abstraction/interfaces/IEntryPoint.sol";

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

        // Call the target wallet with the provided calldata
        (bool success, ) = userOp.sender.call(userOp.callData);
        require(success, "Execution failed");

        bytes4 selector;
        if (userOp.callData.length >= 4) {
            selector = bytes4(userOp.callData[:4]);
        }

        emit OperationExecuted(userOp.sender, selector);
    }
}
