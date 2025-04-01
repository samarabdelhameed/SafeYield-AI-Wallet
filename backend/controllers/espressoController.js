// controllers/espressoController.js

const axios = require('axios');
const ESPRESSO_URL = process.env.ESPRESSO_URL;

const confirmInclusion = async (req, res) => {
  const { userOpHash } = req.body;

  if (!userOpHash) {
    return res.status(400).json({ error: '❌ Missing userOpHash in request body' });
  }

  if (!ESPRESSO_URL) {
    return res.status(500).json({ error: '❌ ESPRESSO_URL not configured in .env' });
  }

  try {
    // 🧪 Step 1: Check Espresso availability (eth_chainId)
    const testConnectionPayload = {
      jsonrpc: "2.0",
      id: 1,
      method: "eth_chainId",
      params: []
    };

    const testResponse = await axios.post(ESPRESSO_URL, testConnectionPayload, {
      headers: { "Content-Type": "application/json" }
    });

    // 🟢 If reachable, move to next step (simulated inclusion check)
    console.log("✅ Connected to Espresso, chainId:", testResponse.data.result);

    // ⛔️ Here you would normally check inclusion using another Espresso API method
    // For now we'll just simulate a positive confirmation for the given hash
    return res.status(200).json({
      message: "✅ UserOpHash received and Espresso is reachable",
      chainId: testResponse.data.result,
      userOpHash,
      inclusionStatus: "⚠️ Simulated (replace with real check)"
    });

  } catch (error) {
    console.error("☕️ Espresso RPC Error:", error?.response?.data || error.message);
    return res.status(500).json({
      error: "❌ Failed to connect to Espresso RPC",
      details: error?.response?.data || error.message
    });
  }
};

module.exports = { confirmInclusion };
