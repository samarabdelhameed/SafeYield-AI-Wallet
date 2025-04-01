const express = require('express');
const router = express.Router();
const { confirmInclusion } = require('../controllers/espressoController');

// Route: POST /api/espresso/confirm
router.post('/confirm', confirmInclusion);

module.exports = router;
