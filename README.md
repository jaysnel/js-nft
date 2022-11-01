# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
a# JS-NFT
Easy solution to deploy your NFT's.

This project is used to deploy your NFT's to the goerli network. You can send an array of items to mint and allow the code to run and deploy to OpenSea test net.
Note: NFT items must follow OpenSea Meta data requiremnets for NFT to mint correctly. You can find requirments here: > (https://docs.opensea.io/docs/metadata-standards).

### What you need
1. Metamask Wallet
2. Private Metamask Key
3. Alchemy account
4. Alchemy API URL


### Steps
Create your json object
Stringify and replace `aiImages` variable in deploy.js

Run:
```
yarn install
npx hardhat run scripts/deploy.js --network goerli
```