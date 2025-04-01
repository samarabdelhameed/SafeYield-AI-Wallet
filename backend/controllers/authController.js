// controllers/authController.js

exports.registerPasskey = async (req, res) => {
    const { address, passkey } = req.body;
  
    if (!address || !passkey) {
      return res.status(400).json({ error: 'Missing address or passkey' });
    }
  
    // Mock register logic
    console.log('🔐 Registered:', address, 'with passkey hash:', passkey);
  
    return res.status(200).json({ message: 'User registered with passkey ✅' });
  };
  
  exports.verifyPasskey = async (req, res) => {
    // Optional second verification if needed
    return res.status(200).json({ message: 'Passkey verified ✅' });
  };
  