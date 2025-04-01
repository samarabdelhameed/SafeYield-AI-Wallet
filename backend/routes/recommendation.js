// routes/recommendation.js

const express = require('express');
const router = express.Router();
const { getRecommendation } = require('../controllers/recommendationController');

// ✅ Route to get AI DeFi recommendation
router.post('/', getRecommendation);

module.exports = router;
