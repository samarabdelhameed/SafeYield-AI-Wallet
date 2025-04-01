// app.js

const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const dotenv = require('dotenv');

// ✅ Load environment variables
dotenv.config();

// ✅ Import routes
const authRoutes = require('./routes/auth');
const intentRoutes = require('./routes/intent');
const recommendationRoutes = require('./routes/recommendation');
const espressoRoutes = require('./routes/espresso');

// ✅ Init Express app
const app = express();

// ✅ Middlewares
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

// ✅ Routes
app.use('/api/auth', authRoutes);
app.use('/api/intent', intentRoutes);
app.use('/api/recommendation', recommendationRoutes);
app.use('/api/espresso', espressoRoutes);

// ✅ Root route
app.get('/', (req, res) => {
  res.send('🧠 SafeYield AI Backend is live!');
});

module.exports = app;
