# 🧠 SafeYield AI Wallet – Smart Contracts

This folder contains the smart contracts powering **SafeYield AI Wallet** – an **EIP-4337-compatible smart account system** that enables **intent-based DeFi execution** with **biometric authentication**, **AI-driven investment logic**, and **cross-chain yield farming** potential.

---

## 🎯 Key Features

| Feature                    | Description                                                         |
| -------------------------- | ------------------------------------------------------------------- |
| ✅ Intent Execution        | Process and dispatch `UserOperation`s based on user-defined intents |
| ✅ Modular Vault System    | Deposit, withdraw, and auto-claim yield via `SafeYieldVault.sol`    |
| ✅ Pluggable Strategies    | Attach yield modules like `FixedRateStrategy` via `IYieldStrategy`  |
| ✅ Passkey Authentication  | On-chain signature verification via `AuthenticationManager.sol`     |
| ✅ Account Abstraction     | Wallet supports `validateUserOp()` + `execute()` as per ERC-4337    |
| ✅ Intent Routing          | `IntentRouter.sol` maps intent categories to destination vaults     |
| ✅ Full Foundry Test Suite | Contract-level tests using Forge & Anvil                            |

---

## 🧩 Contract Flow

```mermaid
flowchart TD
    A[User Wallet (4337)] -->|submit UserOp| B(IntentExecutor)
    B -->|dispatch calldata| C(SafeYieldVault)
    B -->|optional routing| D(IntentRouter)
    C --> E[Strategy Plugin (FixedRate)]
    A -->|validate signature| F(AuthenticationManager)
```

---

## 🛠️ Contracts Overview

| Contract                    | Role                                                                      |
| --------------------------- | ------------------------------------------------------------------------- |
| `SafeYieldVault.sol`        | Core yield vault. Supports `deposit`, `withdraw`, `claimYield`            |
| `FixedRateStrategy.sol`     | Pluggable strategy that accrues static APR on vault deposits              |
| `IYieldStrategy.sol`        | Strategy plugin interface. Vaults can attach/replace strategies           |
| `SafeYieldWallet.sol`       | EntryPoint-compatible wallet that validates and executes `UserOperation`s |
| `AuthenticationManager.sol` | Manages passkey identities, hashes, and signature validation              |
| `IntentExecutor.sol`        | Smart contract that routes raw `callData` to proper vault/target          |
| `IntentRouter.sol`          | Maps intent strings or categories to vault/strategy contracts             |
| `MockDepositTarget.sol`     | Simulated external DeFi target for intent dispatch testing                |
| `MockERC20.sol`             | Test token for mocking real ERC20 usage (e.g. USDC/DAI)                   |

---

## 🧪 Foundry Test Coverage

Run tests:

```bash
forge install
forge build
forge test -vvvv
```

| File                          | Test Scenarios Covered                            |
| ----------------------------- | ------------------------------------------------- |
| `IntentExecutor.t.sol`        | Dispatch calldata, validate access, emit logs     |
| `SafeYieldVault.t.sol`        | Deposit, withdraw, accrue yield, edge cases       |
| `AuthenticationManager.t.sol` | Register + verify passkey, check invalid attempts |
| `SafeYieldWallet.t.sol`       | `validateUserOp`, signature integration, nonce    |
| `IntentRouter.t.sol`          | Route intents to right vaults                     |
| `EarnRouter.t.sol`            | (Optional future extension - investment plan)     |

---

## 📁 Project Structure

```
contracts/
│
├── src/
│   ├── AuthenticationManager.sol
│   ├── EarnRouter.sol
│   ├── IntentExecutor.sol
│   ├── IntentRouter.sol
│   ├── SafeYieldVault.sol
│   ├── SafeYieldWallet.sol
│   │
│   ├── lib/
│   │   └── UserOperation.sol
│   │
│   ├── mocks/
│   │   ├── MockERC20.sol
│   │   └── MockDepositTarget.sol
│   │
│   ├── strategies/
│   │   ├── IYieldStrategy.sol
│   │   └── FixedRateStrategy.sol
│
├── test/
│   ├── AuthenticationManager.t.sol
│   ├── EarnRouter.t.sol
│   ├── IntentExecutor.t.sol
│   ├── IntentRouter.t.sol
│   ├── SafeYieldVault.t.sol
│   ├── SafeYieldWallet.t.sol
│
├── foundry.toml
└── README.md
```

---

## 🔌 Integration Points

| Layer              | Connected To                             |
| ------------------ | ---------------------------------------- |
| Backend            | Submits UserOperations to Wallet         |
| Espresso Sequencer | (Optional) Verifies inclusion of intents |
| StackUp/Pimlico    | Bundler endpoint for UserOp relay        |
| Frontend           | WebAuthn passkey + intent input          |

---

## 🧠 Intent Architecture

This system implements the **Open Intents Framework (ERC-7683)**:

- Intent is parsed from natural language via AI Agent
- Transformed into structured `UserOperation`
- Executed via bundler → EntryPoint → Smart Wallet
- Vault and Strategy plug-ins handle logic modularly

---

## 💡 Targeted Hackathon Tracks

| Track                      | ✅ Covered | Details                                     |
| -------------------------- | ---------- | ------------------------------------------- |
| Open Intents Applications  | ✅         | Full support via intent parsing and routing |
| Best Composable DeFi Apps  | ✅         | Modular vault system + swappable strategies |
| AI + Wallet UI Integration | ✅         | UserOp built via backend AI agent           |
| Core Espresso Challenge    | ✅         | Espresso RPC integration for inclusion      |

---

## 📦 Dependencies

- ✅ Foundry (via `forge install`)
- ✅ Solidity ≥0.8.19
- ✅ OpenZeppelin Contracts v5 (via `lib/openzeppelin-contracts`)
- ✅ ERC-4337 interfaces (UserOperation, EntryPoint)
- ✅ Espresso Sequencer RPC (optional)

---

## 📢 Suggested Next Steps

- ✅ Deploy contracts to Arbitrum Sepolia (for Espresso testing)
- ✅ Integrate with real bundler like StackUp
- ✅ Deploy frontend to submit passkey-authenticated UserOps
- ✅ Test `vault → strategy → yield claim` end-to-end flow

---

## 👩‍💻 Author

Built with ❤️ by **[@samarabdelhameed](https://github.com/samarabdelhameed)**  
for [DoraHacks Build & Brew Hackathon – Espresso Network](https://dorahacks.io/hackathon/build-and-brew)

---
