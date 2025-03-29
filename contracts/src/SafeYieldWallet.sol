// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// ✅ استيراد الستركت من ملف lib (الموحد بين كل العقود)
import {UserOperation} from "./lib/UserOperation.sol";

/// @notice Interface for AuthenticationManager used to verify passkey
interface IAuthenticationManager {
    function login(address user, bytes32 verifier) external view returns (bool);
}

/// @title SafeYieldWallet
/// @notice Smart wallet using external AuthenticationManager for passkey verification
contract SafeYieldWallet {
    /// @notice The only allowed caller for `execute` and `validateUserOp`
    address public immutable entryPoint;

    /// @notice External authentication manager (passkey-based)
    IAuthenticationManager public authManager;

    /// @notice Error if caller is not the configured entry point
    error OnlyEntryPoint();

    /// @param _entryPoint The trusted EntryPoint (ERC-4337 compliant)
    /// @param _authManager Address of the AuthenticationManager contract
    constructor(address _entryPoint, address _authManager) {
        entryPoint = _entryPoint;
        authManager = IAuthenticationManager(_authManager);
    }

    /// @notice Executes a call on behalf of the wallet (only the EntryPoint can call this)
    /// @param target The target contract to call
    /// @param value The ETH value to send
    /// @param data The calldata to pass
    function execute(
        address target,
        uint256 value,
        bytes calldata data
    ) external {
        if (msg.sender != entryPoint) {
            revert OnlyEntryPoint();
        }

        (bool success, ) = target.call{value: value}(data);
        require(success, "Call failed");
    }

    /// @notice Validates a user operation using the AuthenticationManager
    /// @dev Hashes the `signature` bytes and compares them to stored passkey hash
    /// @param op The user operation to validate
    /// @return validationCode 0 if valid, 1 otherwise
    function validateUserOp(
        UserOperation calldata op
    ) external view returns (uint256 validationCode) {
        bytes32 providedVerifier = keccak256(op.signature);
        bool isValid = authManager.login(op.sender, providedVerifier);
        return isValid ? 0 : 1;
    }
}
