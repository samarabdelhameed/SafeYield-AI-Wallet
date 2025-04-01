// config/db.js

const mongoose = require('mongoose');

// ✅ Optional MongoDB connection
const connectDB = async () => {
  const mongoURI = process.env.MONGODB_URI;

  if (!mongoURI) {
    console.log('⚠️  No MongoDB URI provided (DB connection is optional)');
    return;
  }

  try {
    await mongoose.connect(mongoURI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });

    console.log('✅ Connected to MongoDB');
  } catch (err) {
    console.error('❌ MongoDB connection failed:', err.message);
    process.exit(1); // Exit if DB is critical
  }
};

module.exports = connectDB;
