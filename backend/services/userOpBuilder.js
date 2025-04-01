// services/userOpBuilder.js

function buildUserOperation({ sender, action, token, amount, protocol }) {
  const selector = getSelectorForAction(action);

  const userOp = {
    sender,
    callData: `${selector}${encodeParams(amount)}`, // Simplified ABI encoding
    callValue: 0,
    signature: Buffer.from("valid-passkey").toString("hex"),
    nonce: 0,
    callGasLimit: 100000,
    verificationGasLimit: 100000,
    preVerificationGas: 21000,
    maxFeePerGas: 0,
    maxPriorityFeePerGas: 0,
    paymasterAndData: "0x", // ✅ لازم يتبعت حتى لو مفيش paymaster
  };

  return userOp;
}

// 🔁 Map action to function selector (based on vault contract ABI)
function getSelectorForAction(action) {
  if (action === "deposit") return "0xb6b55f25"; // deposit(uint256)
  if (action === "withdraw") return "0x2e1a7d4d"; // withdraw(uint256)
  if (action === "stake") return "0xa694fc3a"; // stake(uint256) (example)
  if (action === "swap") return "0x18cbafe5";  // swap(uint256) (example)
  return "0x"; // fallback
}

// 🔢 Encode value as hex
function encodeParams(amount) {
  return BigInt(amount * 1e18).toString(16).padStart(64, "0");
}

// ✅ Export
module.exports = buildUserOperation;
