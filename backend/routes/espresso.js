const express = require('express');
const router = express.Router();

// Placeholder route
router.post('/', (req, res) => {
  res.json({ message: 'Espresso confirm endpoint working ☕️' });
});

module.exports = router;
