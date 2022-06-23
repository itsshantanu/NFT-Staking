# Simple NFT Stacking Smart Contract

This smart contract stakes the minted NFT and rewards the staker in Custom ERC20 MoonTokens on the basis of time the NFT is staked for.

For Example:-  
    If NFT owner stakes NFT for:-  
    Atleast for 1 month they get 10% APR Reward in the form of MoonToken  
    or atleast 6 months they get 15% APR Reward in the form of MoonToken  
    or 12 months or more they get 25% APR Reward in the form of MoonToken    


## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

```
    ROPSTEN_API_URL = "https://ropsten.infura.io/v3/YOUR_API_KEY"
    PRIVATE_KEY = "YOUR-METAMASK-PRIVATE_KEY"
```

## NPM Packages:

 - [Openzeppelin](https://docs.openzeppelin.com/)
 - [Hardhat Ethers](https://www.npmjs.com/package/hardhat-ethers)
 - [Chai](https://www.npmjs.com/package/chai)
 - [Ethers](https://www.npmjs.com/package/ethers)
 - [ethereum-waffle](https://www.npmjs.com/package/ethereum-waffle)
 - [dotenv](https://www.npmjs.com/package/dotenv)

## Tech Stack:
 - [Node](https://nodejs.org/en/)
 - [Hardhat](https://hardhat.org/tutorial/)
 - [Solidity](https://docs.soliditylang.org/en/v0.8.13)


## Run Locally:

Clone the github repo:
```
https://github.com/itsshantanu/NFT-Staking
```

Install Node Modules
```
npm install
```

Compile
```
npx hardhat compile
```

Test
```
npx hardhat test
```

Deploy on Localhost
```
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost
```

Deploy on Ropsten
```
npx hardhat run scripts/deploy.js --network ropsten
```

Help
```
npx hardhat help
```

## Check live at Ropsten Test Net:
 - [NFTToken](https://ropsten.etherscan.io/address/0x053230409519b504e81fc29CD803f370088eE0B5)
 - [StakeNFT](https://ropsten.etherscan.io/address/0xA5243af1c0bd4163E80CDF9f1d6CC3C2E81CD718)
