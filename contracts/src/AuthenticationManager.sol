// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title AuthenticationManager
/// @notice Stores Passkey verifiers (hashed) for WebAuthn-based auth

contract AuthenticationManager {
    /// @dev Maps user addresses to their passkey verifier hash
    mapping(address => bytes32) public userVerifier;

    event Registered(address indexed user, bytes32 verifier);
    event Authenticated(address indexed user);

    /// @notice Registers a new user with their verifier
    /// @param verifier The hashed passkey (verifier) provided by the frontend
    function register(bytes32 verifier) external {
        require(userVerifier[msg.sender] == 0x0, "Already registered");
        userVerifier[msg.sender] = verifier;
        emit Registered(msg.sender, verifier);
    }

    /// @notice Verifies if the given verifier matches the stored one
    /// @param verifier The hashed passkey sent from the frontend
    function login(bytes32 verifier) external view returns (bool) {
        return userVerifier[msg.sender] == verifier;
    }
}
