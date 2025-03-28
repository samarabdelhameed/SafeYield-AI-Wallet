// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title AuthenticationManager
/// @notice Stores Passkey verifiers (hashed) for WebAuthn-based auth
contract AuthenticationManager {
    /// @dev Maps user addresses to their passkey verifier hash
    mapping(address => bytes32) public userVerifier;

    event Registered(address indexed user, bytes32 verifier);

    /// @notice Registers a new user with their verifier
    function register(bytes32 verifier) external {
        require(userVerifier[msg.sender] == 0x0, "Already registered");
        userVerifier[msg.sender] = verifier;
        emit Registered(msg.sender, verifier);
    }

    /// @notice Verifies if the given verifier matches the stored one
    function login(
        address user,
        bytes32 verifier
    ) external view returns (bool) {
        return userVerifier[user] == verifier;
    }
}
