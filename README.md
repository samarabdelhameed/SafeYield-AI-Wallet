# 💸 SafeYield AI Wallet

> **Your AI-Powered Cross-Chain Wallet for Smarter DeFi Yield**

---

## ❓ Problem

DeFi users struggle with:

- Fragmented yield opportunities across chains.
- Manual research and suboptimal strategies.
- No smart assistant for portfolio automation in self-custodial wallets.

---

## ✅ Solution: SafeYield AI Wallet

SafeYield is an **AI-enhanced, self-custodial wallet** that empowers users to:

- 🧠 Get **AI-driven yield recommendations** across protocols.
- 🚀 Execute onchain **intents** using Espresso fast confirmations.
- 🌉 Perform **seamless cross-chain yield farming** via LayerZero.

It combines **AI + Smart Contracts + Interoperability** in a simple UX.

---

## 🏆 Hackathon Tracks Covered

| Track                               | Details                                                   |
| ----------------------------------- | --------------------------------------------------------- |
| 🧩 Best Composable App ($35K)       | Cross-chain yield execution using Espresso confirmations  |
| 📦 Open Intents Applications ($30K) | Integration with Intents framework (Espresso + LayerZero) |
| 🤖 DeFi + AI Integration            | AI-powered strategy and execution pipeline                |

---

## 🧠 Architecture Overview

```mermaid
flowchart TD
    A[User Wallet (RainbowKit)] -->|Intents| B[Frontend (Next.js)]
    B --> C[Backend (Express + Node.js)]
    C -->|Yield Data| D[AI Agent (LangChain + OpenAI)]
    C -->|Execute| E[Smart Contracts (Foundry)]
    E -->|Cross-chain Ops| F[Espresso + Intents API + LayerZero]
    E --> G[Protocols (Aave, Uniswap, Curve)]
```

---

## 🛠 Tech Stack

| Layer           | Tech                                                            |
| --------------- | --------------------------------------------------------------- |
| Smart Contracts | **Foundry**, based on Earn contracts                            |
| Frontend        | **Next.js + TypeScript + TailwindCSS + Shadcn UI + RainbowKit** |
| Backend         | **Node.js + Express + PostgreSQL**                              |
| AI Engine       | **LangChain + OpenAI/GPT API**                                  |
| Web3            | **Ethers.js + Wagmi + Cross-chain SDKs**                        |
| Interop         | **Espresso Confirmations + LayerZero**                          |

---

## 🔍 Features

- ✅ AI-generated yield plans based on on-chain data
- 🔁 Auto execution of on-chain intents
- 🌉 Bridge assets across chains with 1-click
- 📊 Transparent dashboards of yield returns

---

## 🧪 How to Run Locally

1. **Install Smart Contract Tools**

   ```bash
   cd contracts/
   forge install && forge test
   ```

2. **Run Backend**

   ```bash
   cd backend/
   npm install
   npm run dev
   ```

3. **Run Frontend**

   ```bash
   cd frontend/
   npm install
   npm run dev
   ```

4. **Connect Wallet** using RainbowKit and test Intent-based AI recommendations

---

## 🔐 Security & Future Enhancements

- Modular contracts for recovery and permissions
- zkSync/zk-rollup support for privacy yield
- AI fine-tuning per wallet strategy

---

## 📜 License

MIT © 2025 SafeYield AI Wallet
