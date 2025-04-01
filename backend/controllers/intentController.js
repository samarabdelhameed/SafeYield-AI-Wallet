const { parseUserIntent } = require('../services/aiAgent');
const buildUserOperation = require('../services/userOpBuilder'); // ✅ من غير destructuring
const { sendUserOperation } = require('../services/bundlerService');

const handleIntent = async (req, res) => {
  try {
    const { userAddress, intentText } = req.body;

    if (!userAddress || !intentText) {
      return res.status(400).json({ error: 'Missing userAddress or intentText' });
    }

    // 🧠 AI intent parsing
    const parsed = await parseUserIntent(intentText);

    if (!parsed || !parsed.action || !parsed.amount || !parsed.token) {
      return res.status(422).json({ error: 'Invalid parsed intent from AI' });
    }

    // 🧱 Build the user operation
    const userOp = await buildUserOperation({
      userAddress,
      action: parsed.action,
      amount: parsed.amount,
      token: parsed.token,
      protocol: parsed.protocol,
    });

    // 🚀 Send to bundler
    const bundlerResponse = await sendUserOperation(userOp);

    return res.status(200).json({
      message: 'Intent processed successfully!',
      parsed,
      userOperation: userOp,
      bundlerResponse,
    });
  } catch (error) {
    console.error('❌ Intent Error:', error);
    res.status(500).json({ error: 'Internal server error in intent handler' });
  }
};

module.exports = {
  handleIntent,
};
