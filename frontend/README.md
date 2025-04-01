```md
# 💻 SafeYield AI Wallet – Frontend

> The intuitive Web3 interface for the future of smart, biometric, intent-based DeFi.

This is the frontend layer for **SafeYield AI Wallet**, a fully composable, EIP-4337 compatible smart wallet powered by AI agents, Espresso confirmations, and biometric authentication. Designed to win DoraHacks 🏆

---

## 🌟 Key Features

| Feature                    | Description                                                       |
| -------------------------- | ----------------------------------------------------------------- |
| ✅ Biometric login         | Connect wallet with WebAuthn & passkey-ready support              |
| ✅ Intent Input UI         | Users write intents like: "I want to stake 100 USDC on Aave"      |
| ✅ AI Recommendation View  | Shows selected protocol & strategy recommended by LangChain agent |
| ✅ UserOperation Generator | Converts parsed AI response into an EIP-4337 UserOperation        |
| ✅ Espresso Integration    | Displays confirmation status via Espresso Sequencer               |
| ✅ Cross-chain Portfolio   | Track assets, balances, yield strategies across protocols         |

---

## 📂 Project Structure
```

frontend/
│
├── pages/
│ ├── index.tsx # Landing + Passkey login
│ ├── dashboard.tsx # AI + Wallet summary + Espresso snapshot
│ ├── intent.tsx # Intent input + recommendations
│ ├── confirm.tsx # Espresso + EntryPoint confirmation
│ └── portfolio.tsx # Current assets, APYs, returns
│
├── components/
│ ├── WalletConnect.tsx # Connect using RainbowKit
│ ├── IntentForm.tsx # Natural language form
│ ├── AIRecommendation.tsx # Display selected protocol/token/strategy
│ ├── UserOpPreview.tsx # EIP-4337 preview of generated transaction
│ ├── EspressoStatus.tsx # Confirmation UI from Espresso
│ ├── Toasts.tsx # Notifications
│ └── Layout.tsx # Shared page wrapper
│
├── lib/
│ ├── api.ts # Axios API client
│ ├── types.ts # Shared types (UserOperation, AI result)
│ └── utils.ts # Helpers, formatters
│
├── styles/
│ ├── globals.css
│ └── tailwind.config.ts
│
├── public/
│ └── logo.png
│
├── .env.local.example
└── README.md

````

---

## 🧭 UI Flow

```mermaid
flowchart LR
  A[Landing Page /] --> B[WalletConnect.tsx]
  B --> C[Dashboard.tsx]
  C --> D[IntentForm.tsx]
  D --> E[AIRecommendation.tsx]
  E --> F[UserOpPreview.tsx]
  F --> G[Confirm.tsx]
  G --> H[EspressoStatus.tsx]
  C --> I[Portfolio.tsx]
````

---

## 🧪 How to Run

```bash
cd frontend/
npm install
npm run dev
```

➡️ Visit `http://localhost:3000`

Ensure the backend is running on port `5050`.

---

## 🔑 Environment Variables

Copy `.env.local.example` to `.env.local` and fill in:

```env
NEXT_PUBLIC_BACKEND_URL=http://localhost:5050
NEXT_PUBLIC_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
NEXT_PUBLIC_ESPRESSO_URL=https://milan-devnet.rpc.caldera.xyz
```

---

## 🛠 Stack Breakdown

| Layer          | Tech Stack                            |
| -------------- | ------------------------------------- |
| Framework      | Next.js + TypeScript                  |
| Styling        | Tailwind CSS + Shadcn UI              |
| Wallet Connect | RainbowKit + wagmi                    |
| Auth           | WebAuthn Passkeys (via backend)       |
| Web3           | ethers.js + JSON-RPC                  |
| State Mgmt     | useState/useEffect (Zustand optional) |
| AI             | LangChain / GPT backend agent         |

---

## ✅ Pages Summary

| Page      | Path         | Purpose                                                |
| --------- | ------------ | ------------------------------------------------------ |
| Landing   | `/`          | Connect wallet, login via Passkey                      |
| Dashboard | `/dashboard` | Show wallet, AI suggestions, Espresso confirmation     |
| Intent    | `/intent`    | Capture free text intent + get AI response             |
| Confirm   | `/confirm`   | View confirmation status (HotShot + EntryPoint)        |
| Portfolio | `/portfolio` | View current assets, vault balances, estimated returns |

---

## 📦 Component Responsibilities

| Component          | Role                                                       |
| ------------------ | ---------------------------------------------------------- |
| `WalletConnect`    | Wrapper for RainbowKit + wagmi wallet integration          |
| `IntentForm`       | Form for typing intents and triggering AI pipeline         |
| `AIRecommendation` | Displays LangChain agent result (strategy/token/protocol)  |
| `UserOpPreview`    | Builds a readable EIP-4337 `UserOperation` preview         |
| `EspressoStatus`   | Shows confirmation status (HotShot / userOpHash / tx hash) |
| `Toasts`           | UI feedback for confirmation, errors, success              |

---

## 💎 UX Guidelines

- ✅ Mobile responsive with Tailwind breakpoints
- ✨ Animations with Framer Motion (optional)
- 🧠 Typing suggestions: autofill intents from history
- 🎯 One-click UX: type → recommend → confirm

---

## 📹 Demo Video – What to Show

1. Open landing page & connect wallet
2. Login with Passkey (FaceID / Fingerprint)
3. Go to `/intent` → type: _"I want to stake 100 USDC"_
4. See AI recommendation: **Aave v3 / 5%**
5. Preview UserOperation
6. Submit → Espresso confirms
7. `/portfolio` shows updated USDC → staked + yield %

---

## 🚀 Tracks Covered (Frontend-Specific)

| Track                        | Covered via…                                       |
| ---------------------------- | -------------------------------------------------- |
| ✅ Open Intents Applications | Intent input UI + backend call + AI recommendation |
| ✅ Best Composable App       | Portfolio composition across protocols             |
| ✅ Wallet UI Integration     | Espresso confirmation integrated into interface    |
| ✅ AI Agent Integration      | AI frontend UX + recommendation step               |

---

## 🧑‍💻 Built with ❤️ by

**[@samarabdelhameed](https://github.com/samarabdelhameed)**  
_DoraHacks Build & Brew Hackathon 2025_

---

```

```
