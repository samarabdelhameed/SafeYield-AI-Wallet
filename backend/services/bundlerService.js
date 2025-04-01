// services/bundlerService.js

const axios = require("axios");

const BUNDLER_URL = process.env.BUNDLER_URL;
const ENTRY_POINT = process.env.ENTRY_POINT_ADDRESS || "0x0000000000000000000000000000000000000000"; // fallback dummy

async function sendUserOperation(userOp) {
  if (!BUNDLER_URL) {
    throw new Error("❌ BUNDLER_URL not set in environment.");
  }

  if (!process.env.ENTRY_POINT_ADDRESS) {
    console.warn("⚠️ ENTRY_POINT_ADDRESS not set — using dummy address");
  }

  try {
    const rpcPayload = {
      jsonrpc: "2.0",
      id: 1,
      method: "eth_sendUserOperation",
      params: [userOp, ENTRY_POINT],
    };

    const response = await axios.post(BUNDLER_URL, rpcPayload, {
      headers: {
        "Content-Type": "application/json",
      },
    });

    const result = response.data.result;
    console.log("✅ UserOperation sent to bundler.");
    if (result) console.log("🔗 Operation Hash:", result);

    return result;
  } catch (error) {
    console.error("❌ Failed to send UserOperation to bundler:");
    if (error.response?.data) {
      console.error(error.response.data);
    } else {
      console.error(error.message);
    }
    throw error;
  }
}

module.exports = { sendUserOperation };
