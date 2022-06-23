const hre = require('hardhat');

async function main() {
 
  // For NFT

  const NFT = await hre.ethers.getContractFactory('MyNFT');
  const nft = await NFT.deploy();

  await nft.deployed();

  console.log('NFTToken deployed to:', nft.address);

  // For StakeNFT

  const StakeNFT = await hre.ethers.getContractFactory('StakeNFT');
  const stakeNft = await StakeNFT.deploy(nft.address);

  await stakeNft.deployed();

  console.log('StakeNFT deployed to:', stakeNft.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
