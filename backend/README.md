backend/
│
├── controllers/  
│ ├── authController.js
│ ├── intentController.js
│ ├── recommendationController.js
│ └── espressoController.js
│
├── routes/  
│ ├── auth.js
│ ├── intent.js
│ ├── recommendation.js
│ └── espresso.js
│
├── services/  
│ ├── userOpBuilder.js
│ ├── bundlerService.js
│ └── aiAgent.js
│
├── models/  
│ ├── User.js
│ └── Transaction.js
│
├── utils/  
│ └── logger.js
│
├── config/ # config files مثل db.js و env loader
│ ├── db.js
│ └── dotenv.js
│
├── app.js # Express instance & middlewares
├── server.js #
├── .env.example
└── package.json

````

---


```markdown
# 🧠 SafeYield AI Wallet — Backend (Express.js)

> ✨ Secure. Smart. Intent-based. Welcome to the future of programmable wallets powered by AI, WebAuthn, and EIP-4337.

## 🔍 Overview

This backend powers the SafeYield AI Wallet's smart intent execution system. It:

- Authenticates users via Passkey/WebAuthn (Passwordless)
- Parses user intents like "I want to earn yield on my USDC"
- Calls an AI agent to recommend the best DeFi protocol
- Constructs and sends EIP-4337 `UserOperation`s to the Bundler
- Verifies sequencing through Espresso integration

---

## 🛠️ Tech Stack

| Layer        | Tech                      |
|--------------|---------------------------|
| Server       | Node.js + Express.js      |
| Auth         | Passkey/WebAuthn          |
| AI Engine    | OpenAI API + LangChain    |
| Intents      | ERC-7683 / Safe Abstraction |
| Sequencer    | Espresso Systems          |
| DB (optional)| MongoDB / PostgreSQL      |

---

## 🧭 API Endpoints

| Method | Route                     | Purpose                              |
|--------|---------------------------|--------------------------------------|
| POST   | `/api/auth/passkey`       | Register/Login user via passkey      |
| POST   | `/api/intent`             | Analyze user intent text             |
| POST   | `/api/recommendation`     | Get AI recommendation (e.g., Aave)   |
| POST   | `/api/espresso/confirm`   | Confirm tx with Espresso sequencer   |

---

## 🧠 AI Agent

- Reads user's DeFi portfolio
- Suggests best yield option
- Simulates intent as EIP-4337 UserOperation

---

## 🔐 Auth Flow (Passkey)

- Frontend initiates WebAuthn
- Sends result to `/api/auth/passkey`
- Backend registers/verifies via FIDO2
- Associates a `verifier` with user address

---

## 🔄 Intents to Execution Flow

1. User writes: *"I want to stake 100 USDC"*
2. `/api/intent` parses + extracts action + token + amount
3. `/api/recommendation` returns best protocol (e.g., Aave)
4. `/userOpBuilder.js` builds a `UserOperation`
5. `/api/espresso/confirm` validates it with sequencer
6. Bundler submits tx via EntryPoint

---

## 🧪 Testing & Local Dev

```bash
cd backend
npm install
npm run dev
````

Use tools like [Postman](https://www.postman.com/) to test endpoints.

---

## 📦 Folder Structure

Refer to the project structure in this repo: `backend/`

---

## 💡 Open Intents Compatibility

This backend integrates the Open Intents idea via:

- `IntentExecutor.sol` contract
- `/api/intent` & `/api/recommendation` AI middleware
- Espresso + bundler-ready `UserOperation` builder

---

## 🧩 Integration With Smart Contracts

The following contracts are used:

- ✅ `IntentExecutor.sol` — Executes the encoded call
- ✅ `SafeYieldVault.sol` — Target of most DeFi intents
- ✅ `AuthenticationManager.sol` — Passkey auth verification
- ✅ `SafeYieldWallet.sol` — ERC-4337 Smart Wallet
- ✅ `EntryPoint.sol` — Supports bundling UserOperations

---

## 🏆 Target Hackathon Tracks Covered

| Track                             | ✅  |
| --------------------------------- | --- |
| Open Intents (Espresso + ERC7683) | ✅  |
| AI + Wallet UI Integration        | ✅  |
| Core Espresso Challenge           | ✅  |
| Best Composable DeFi Apps         | ✅  |

---

## 👩‍💻 Authors

Built by [@samarabdelhameed](https://github.com/samarabdelhameed)
