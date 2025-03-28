// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/IntentRouter.sol";

contract IntentRouterTest is Test {
    IntentRouter public router;
    address public user = address(0xBEEF);
    string public action = "stake";
    uint256 public amount = 1000;

    // تعريف الحدث IntentExecuted
    event IntentExecuted(address indexed user, string action, uint256 amount);

    function setUp() public {
        router = new IntentRouter();
    }

    // اختبار تنفيذ النية (Intent)
    function testExecuteIntent() public {
        // توقع أن يتم إصدار الحدث
        vm.expectEmit(true, true, true, true);
        emit IntentExecuted(user, action, amount);

        // تنفيذ النية
        vm.prank(user);
        router.executeIntent(user, action, amount);
    }

    // اختبار التعامل مع أفعال مختلفة
    function testDifferentActions() public {
        // اختبار الأفعال المختلفة والتأكد من الحدث
        string memory action1 = "stake";
        string memory action2 = "withdraw";

        // اختبار تنفيذ الفعل الأول
        vm.expectEmit(true, true, true, true);
        emit IntentExecuted(user, action1, amount);
        vm.prank(user);
        router.executeIntent(user, action1, amount);

        // اختبار تنفيذ الفعل الثاني
        vm.expectEmit(true, true, true, true);
        emit IntentExecuted(user, action2, amount);
        vm.prank(user);
        router.executeIntent(user, action2, amount);
    }
}
