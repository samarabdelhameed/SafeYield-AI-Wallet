const express = require('express');
const router = express.Router();

// Placeholder route
router.post('/', (req, res) => {
  res.json({ message: 'Recommendation endpoint working ✅' });
});

module.exports = router;
