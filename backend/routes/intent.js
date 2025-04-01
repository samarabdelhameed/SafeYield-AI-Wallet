const express = require('express');
const router = express.Router();

// Placeholder route
router.post('/', (req, res) => {
  res.json({ message: 'Intent endpoint hit ✅' });
});

module.exports = router;
