# 🧠 SafeYield AI Wallet – Smart Contracts

This folder contains the smart contracts powering **SafeYield AI Wallet** – an EIP-4337-compatible smart account system that enables intent-based DeFi execution with biometric authentication, AI-driven investment recommendations, and cross-chain yield strategies.

---

## 🎯 Key Features

| Feature                             | Description                                                                |
| ----------------------------------- | -------------------------------------------------------------------------- |
| ✅ **Intent Execution**             | Execute user operations as intents via `IntentExecutor.sol`                |
| ✅ **Modular Vault System**         | Deposit, withdraw, and auto-claim yield via `SafeYieldVault.sol`           |
| ✅ **Plug-and-Play Strategies**     | Fixed-rate yield strategies via `IYieldStrategy` interface                 |
| ✅ **Authentication with Passkeys** | WebAuthn-style on-chain verification via `AuthenticationManager.sol`       |
| ✅ **EIP-4337 Integration**         | Smart account logic in `SafeYieldWallet.sol` mimicking EntryPoint behavior |
| ✅ **Intent Routing**               | Route user-defined intents to target protocols via `IntentRouter.sol`      |
| ✅ **Testing with Foundry**         | Comprehensive test suite across all contracts                              |

---

## 💡 Targeted Hackathon Tracks

This smart contract stack aligns directly with the following DoraHacks tracks:

| Track                          | Our Integration                                                                              |
| ------------------------------ | -------------------------------------------------------------------------------------------- |
| **Open Intents Applications**  | Intent-based architecture via `IntentExecutor.sol`, `IntentRouter.sol` + `UserOperation.sol` |
| **Best Composable Apps**       | Modular yield strategies + vaults compatible with Aave, Compound (future-ready)              |
| **AI + Wallet UI Integration** | Agents analyze user state and generate `UserOperation` for execution                         |
| **Core Espresso Challenge**    | Espresso sequencer ready for integration with intent settlement                              |

---

## 🛠️ Contracts Overview

| Contract                    | Role                                                            |
| --------------------------- | --------------------------------------------------------------- |
| `SafeYieldVault.sol`        | Vault for deposits, withdrawals, and auto-claiming yield        |
| `IYieldStrategy.sol`        | Interface for dynamic strategy integration                      |
| `FixedRateStrategy.sol`     | Example yield plugin with static APR                            |
| `SafeYieldWallet.sol`       | Smart Account wallet with EIP-4337-style validation + execution |
| `AuthenticationManager.sol` | Verifies users via passkey hash (WebAuthn-like auth)            |
| `IntentExecutor.sol`        | Executes a `UserOperation` or batch (intents)                   |
| `IntentRouter.sol`          | Handles routing of text-based actions to proper contracts       |
| `MockDepositTarget.sol`     | Dummy contract for simulating external target calls             |
| `MockERC20.sol`             | Test token for validating transfers, deposits, and balances     |

---

## 🔬 Test Coverage

All contracts are tested using Foundry with high verbosity logs (`forge test -vvvv`).  
Sample tests implemented include:

- ✅ `IntentExecutor.t.sol`: Execute intent, batch intents, emit event
- ✅ `SafeYieldVault.t.sol`: Deposit, withdraw, auto-claim, yield accrual
- ✅ `AuthenticationManager.t.sol`: Register and verify passkey
- ✅ `SafeYieldWallet.t.sol`: Validate `UserOperation` with correct passkey
- ✅ `IntentRouter.t.sol`: Route different intents
- ✅ `EarnRouter.t.sol`: (Optional placeholder)

---

## 📂 Project Structure

```

contracts/
│
├── src/
│ ├── AuthenticationManager.sol
│ ├── EarnRouter.sol
│ ├── IntentExecutor.sol
│ ├── IntentRouter.sol
│ ├── SafeYieldVault.sol
│ ├── SafeYieldWallet.sol
│ │
│ ├── lib/
│ │ └── UserOperation.sol
│ │
│ ├── mocks/
│ │ ├── MockERC20.sol
│ │ └── MockDepositTarget.sol
│ │
│ ├── strategies/
│ │ ├── IYieldStrategy.sol
│ │ └── FixedRateStrategy.sol
│
├── test/
│ ├── AuthenticationManager.t.sol
│ ├── EarnRouter.t.sol
│ ├── IntentExecutor.t.sol
│ ├── IntentRouter.t.sol
│ ├── SafeYieldVault.t.sol
│ ├── SafeYieldWallet.t.sol
│
├── foundry.toml
└── README.md

```

---

## ⚙️ Tools & Stack

- 🧱 **Foundry** for contract development and testing
- 🧠 **EIP-4337 (Account Abstraction)** structure for smart wallets
- 🧬 **Modular vault strategies** (Composable)
- 🌐 **Passkey Authentication** via keccak256 of user credential
- 🔁 **Intent Framework**: ERC-7683-ready structure
- 🔗 **Espresso / HotShot (optional)**: Sequencer-based settlement

---

## 📢 Next Steps

- 🔄 Deploy contracts to Sepolia for Espresso/Intents testing
- 🧪 Integrate with StackUp or Pimlico bundler
- ⚡ Connect the AI agent from `ai/` folder to submit `UserOperation`s here
- 🌉 Plug in actual DeFi strategies (Aave, Compound) into `IYieldStrategy`

---

## 👨‍🔬 Authors & Contributions

Developed by **Sama7.eth** for DoraHacks 2025.

Looking to build the future of AI-driven DeFi experiences with account abstraction, biometric auth, and intuitive intent-based UX.

---

```

```
