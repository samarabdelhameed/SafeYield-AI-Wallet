// services/aiAgent.js

/**
 * Temporary Mock AI Agent to simulate intent parsing.
 * Replace this with OpenAI integration once you get access.
 */

async function parseUserIntent(prompt) {
  console.log('⚠️  Mock AI Activated. No real OpenAI API call.');

  // Fake response simulating parsed intent
  return {
    action: "stake",
    token: "USDC",
    amount: "100",
    protocol: "Aave"
  };
}

module.exports = { parseUserIntent };
