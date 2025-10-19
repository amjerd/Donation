# 💰 Donation Smart Contract

This is a simple and gas-optimized **Ethereum Donation Contract** written in Solidity.  
It allows anyone to **donate ETH**, keeps track of **each donor’s contribution**, and lets only the **owner** withdraw the total collected funds.

---

## ⚙️ Features

- **Donate ETH** directly through the `Donate()` function.  
- **Automatic donation tracking** when ETH is sent directly to the contract (via `receive()` or `fallback()`).
- **Total donation record** of all contributors.
- **Owner-only withdrawal** function for secured fund management.
- **Gas optimization techniques**:
  - `immutable` used for the owner address.
  - `uint256` used instead of smaller types for efficient gas usage.

---

## 🧠 How It Works

### 1. Deploying
When you deploy the contract:
- The **deployer** becomes the **owner** (immutable).
- The contract starts with a `totalDonation` of `0`.

### 2. Donating
Anyone can donate using:
```solidity
Donate()
