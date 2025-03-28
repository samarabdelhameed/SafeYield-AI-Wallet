// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IAuthenticationManager {
    function login(address user, bytes32 verifier) external view returns (bool);
}

/// @notice Struct representing a user operation (Account Abstraction EIP-4337 style)
struct UserOperation {
    address sender;
    bytes signature;
    bytes callData;
    uint256 nonce;
}

/// @title SafeYieldWallet
/// @notice Smart wallet using external AuthenticationManager for passkey verification
contract SafeYieldWallet {
    address public immutable entryPoint;
    IAuthenticationManager public authManager;

    error OnlyEntryPoint();

    constructor(address _entryPoint, address _authManager) {
        entryPoint = _entryPoint;
        authManager = IAuthenticationManager(_authManager);
    }

    /// @notice Executes a call on behalf of the wallet (only entry point)
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

    /// @notice Verifies a user operation using the AuthenticationManager
    function validateUserOp(
        UserOperation calldata op
    ) external view returns (uint256) {
        bytes32 providedVerifier = keccak256(op.signature);
        bool isValid = authManager.login(op.sender, providedVerifier);
        return isValid ? 0 : 1;
    }
}
