// scripts/testBundler.js
require('dotenv').config();
const axios = require('axios');

const test = async () => {
  try {
    const bundlerUrl = process.env.RPC_URL;
    const entryPoint = process.env.ENTRY_POINT_ADDRESS;

    const userOp = {
      sender: "0x000000000000000000000000000000000000dead",
      callData: "0x",
      callValue: "0",
      signature: "0x",
      nonce: "0",
      callGasLimit: "100000",
      verificationGasLimit: "100000",
      preVerificationGas: "21000",
      maxFeePerGas: "0",
      maxPriorityFeePerGas: "0"
    };

    const res = await axios.post(bundlerUrl, {
      jsonrpc: "2.0",
      id: 1,
      method: "eth_sendUserOperation",
      params: [userOp, entryPoint],
    });

    console.log("✅ Bundler Test Success:", res.data);
  } catch (err) {
    console.error("❌ Bundler Test Failed:", err.message || err);
  }
};

test();
