// routes/auth.js

const express = require('express');
const router = express.Router();
const { registerPasskey, verifyPasskey } = require('../controllers/authController');

router.post('/passkey', registerPasskey); // Unified endpoint (register/login)
router.post('/verify', verifyPasskey);     // Optional: second-step verification

module.exports = router;
