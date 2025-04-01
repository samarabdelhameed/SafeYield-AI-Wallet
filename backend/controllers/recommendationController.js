// controllers/recommendationController.js

const { parseUserIntent } = require('../services/aiAgent');

/**
 * @desc Receive user's natural language and respond with structured DeFi recommendation
 * @route POST /api/recommendation
 */
const getRecommendation = async (req, res) => {
  const { prompt } = req.body;

  if (!prompt) {
    return res.status(400).json({ error: 'Prompt is required.' });
  }

  try {
    const intent = await parseUserIntent(prompt);

    return res.json({
      success: true,
      intent,
      message: '✅ AI recommendation generated successfully',
    });
  } catch (error) {
    console.error('❌ AI Recommendation Error:', error.message);
    return res.status(500).json({ error: 'Failed to generate recommendation.' });
  }
};

module.exports = { getRecommendation };
