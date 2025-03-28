// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/SafeYieldWallet.sol";
import "../src/AuthenticationManager.sol";

contract SafeYieldWalletTest is Test {
    AuthenticationManager public auth;
    SafeYieldWallet public wallet;
    address public entryPoint = address(0x1234);
    address public user = address(0xBEEF);
    bytes32 public validPasskeyVerifier;

    function setUp() public {
        auth = new AuthenticationManager();
        wallet = new SafeYieldWallet(entryPoint, address(auth));

        validPasskeyVerifier = keccak256("valid-passkey");

        vm.prank(user);
        auth.register(validPasskeyVerifier);
    }

    function testOnlyEntryPointCanExecute() public {
        vm.expectRevert(SafeYieldWallet.OnlyEntryPoint.selector);
        wallet.execute(address(0x123), 0, "");
    }

    function testValidateUserOpShouldFailIfWrongPasskey() public {
        UserOperation memory op = UserOperation({
            sender: user,
            signature: abi.encode("wrong-passkey"),
            callData: "",
            nonce: 0
        });

        vm.prank(entryPoint);
        uint256 result = wallet.validateUserOp(op);
        assertEq(result, 1, "Validation should fail for wrong passkey");
    }

    function testValidateUserOpShouldSucceed() public {
        // تسجيل المستخدم فقط مرة واحدة
        string memory rawPasskey = "valid-passkey";
        bytes32 hashed = keccak256(abi.encodePacked(rawPasskey));

        // تأكد من أن التسجيل يتم فقط مرة واحدة
        vm.prank(user);
        try auth.register(hashed) {
            // إذا فشل التسجيل، نحن في مرحلة اختبار، لذلك لا نقوم بعمل شيء هنا.
        } catch (bytes memory) {}

        // بناء op بنفس الـ passkey الصحيح
        UserOperation memory op = UserOperation({
            sender: user,
            signature: abi.encodePacked(rawPasskey),
            callData: "",
            nonce: 0
        });

        // محاولة تحقق من عملية التوثيق
        vm.prank(entryPoint);
        uint256 result = wallet.validateUserOp(op);
        assertEq(result, 0, "Validation should succeed for correct passkey");
    }
}
