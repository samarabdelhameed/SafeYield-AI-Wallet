// routes/intent.js

const express = require('express');
const router = express.Router();

// ✅ Import the intent handler
const { handleIntent } = require('../controllers/intentController');

// ✅ Route for handling user intent
router.post('/', handleIntent);

module.exports = router;
