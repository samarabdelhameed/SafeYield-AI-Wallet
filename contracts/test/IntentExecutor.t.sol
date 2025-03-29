// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import {IntentExecutor} from "../src/IntentExecutor.sol";
import {SafeYieldWallet} from "../src/SafeYieldWallet.sol";
import {AuthenticationManager} from "../src/AuthenticationManager.sol";
import {MockERC20} from "../src/mocks/MockERC20.sol";
import {MockDepositTarget} from "../src/mocks/MockDepositTarget.sol";
import {UserOperation} from "../src/lib/UserOperation.sol";

contract IntentExecutorTest is Test {
    IntentExecutor public executor;
    SafeYieldWallet public wallet;
    AuthenticationManager public auth;
    MockERC20 public token;
    MockDepositTarget public mockDeposit;

    address user = address(0xbeef);
    bytes32 passkey = keccak256("valid-passkey");

    event OperationExecuted(address indexed wallet, bytes4 indexed selector);

    function setUp() public {
        auth = new AuthenticationManager();
        vm.prank(user);
        auth.register(passkey);

        wallet = new SafeYieldWallet(address(this), address(auth));
        executor = new IntentExecutor(address(this)); // simulate entryPoint
        token = new MockERC20("Mock Token", "MOCK");
        mockDeposit = new MockDepositTarget();

        token.mint(address(wallet), 100 ether);
    }

    function testExecuteDeposit() public {
        bytes memory callData = abi.encodeWithSignature(
            "deposit(uint256)",
            1 ether
        );

        UserOperation memory userOp = UserOperation({
            sender: address(mockDeposit),
            signature: abi.encode("valid-passkey"),
            callData: callData,
            nonce: 0,
            callGasLimit: 100_000,
            verificationGasLimit: 100_000,
            preVerificationGas: 21_000,
            maxFeePerGas: tx.gasprice,
            maxPriorityFeePerGas: tx.gasprice
        });

        bytes4 selector = bytes4(keccak256("deposit(uint256)"));

        vm.expectEmit(true, true, true, true);
        emit OperationExecuted(address(mockDeposit), selector);

        executor.execute(userOp);
    }
}
