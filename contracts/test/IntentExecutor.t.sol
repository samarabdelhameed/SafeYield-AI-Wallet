// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import {IntentExecutor} from "../src/IntentExecutor.sol";
import {SafeYieldWallet} from "../src/SafeYieldWallet.sol";
import {AuthenticationManager} from "../src/AuthenticationManager.sol";
import {UserOperation} from "account-abstraction/interfaces/UserOperation.sol";
import {MockERC20} from "../src/mocks/MockERC20.sol";

contract IntentExecutorTest is Test {
    IntentExecutor public executor;
    SafeYieldWallet public wallet;
    AuthenticationManager public auth;
    MockERC20 public token;

    address user = address(0xbeef);
    bytes32 passkey = keccak256("valid-passkey");

    function setUp() public {
        auth = new AuthenticationManager();
        vm.prank(user);
        auth.register(passkey);

        wallet = new SafeYieldWallet(address(auth));
        executor = new IntentExecutor(address(this)); // simulate entryPoint
        token = new MockERC20("Mock Token", "MOCK");

        token.mint(address(wallet), 100 ether); // simulate some balance in wallet
    }

    function testExecuteDeposit() public {
        // simulate userOp to call deposit
        bytes memory callData = abi.encodeWithSignature(
            "deposit(uint256)",
            1 ether
        );

        UserOperation memory userOp = UserOperation({
            sender: address(wallet),
            nonce: 0,
            initCode: "",
            callData: callData,
            callGasLimit: 100000,
            verificationGasLimit: 100000,
            preVerificationGas: 21000,
            maxFeePerGas: tx.gasprice,
            maxPriorityFeePerGas: tx.gasprice,
            paymasterAndData: "",
            signature: bytes("valid-passkey")
        });

        // Send the token to the user first
        token.mint(user, 2 ether);

        // Simulate approval from user
        vm.prank(user);
        token.approve(address(wallet), 1 ether);

        // now execute the operation
        vm.expectEmit(true, true, true, true);
        emit OperationExecuted(address(wallet), bytes4(callData[:4]));

        executor.execute(userOp);

        // Assert deposit success (inside SafeYieldWallet logic)
        assertEq(token.balanceOf(user), 1 ether); // 2 - 1 sent to wallet
    }

    event OperationExecuted(address indexed wallet, bytes4 indexed selector);
}
