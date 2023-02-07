const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Staking", () => {

  let owner;
  let MyNFT;
  let myNft;
  let StakeNFT;
  let stakeNft;
  let addr1;
  let addr2;

  beforeEach(async () => {
    [owner, addr1, addr2] = await ethers.getSigners();

    // NFT Contract 

    MyNFT =  await ethers.getContractFactory('MyNFT');
    myNft =  await MyNFT.deploy();
    await myNft.deployed();

    myNftAddress =  myNft.address;

    // NFT Staking

    StakeNFT = await ethers.getContractFactory('StakeNFT');
    stakeNft = await StakeNFT.deploy(myNftAddress);
    await myNft.deployed();

    stakeNftAddress = stakeNft.address;
  });

  it('Should mint the NFT', async () => {
    await myNft.mint(addr1.address, 1, 100, 0x00);
    expect(await myNft.balanceOf(addr1.address, 1)).to.equal(100);
  });

  it('Should be able to stake minted NFT', async () => {
    await myNft.mint(addr1.address, 1, 100, 0x00);
    await myNft.connect(addr1).setApprovalForAll(stakeNftAddress, true);
    await stakeNft.connect(addr1).stake(1, 100);
    const stakeInfo = await stakeNft.stakeInfos(1);
    expect(stakeInfo.tokenOwner).to.equal(addr1.address);
    expect(stakeInfo.stakeAmount).to.equal(100);
  });

  it('Should not allow non-owner to unstake NFT', async () => {
    await myNft.mint(addr1.address, 1, 100, 0x00);
    await myNft.connect(addr1).setApprovalForAll(stakeNftAddress, true);
    await stakeNft.connect(addr1).stake(1, 100);
    await expect(stakeNft.connect(addr2).unstake(1, 100)).to.be.revertedWith("You can't unstake as you are not a owner");
  });

  it('Should be able to unstake the staked NFT', async () => {
    await myNft.mint(addr1.address, 1, 100, 0x00);
    await myNft.connect(addr1).setApprovalForAll(stakeNftAddress, true);
    await stakeNft.connect(addr1).stake(1, 100);
    await stakeNft.connect(addr1).unstake(1, 100);
    expect(await stakeNft.balanceOf(addr1.address)).to.equal(0);
  })

  it('Should be able to unstake NFT after 4 months', async () => {
    await myNft.mint(addr1.address, 1, 100, 0x00);
    await myNft.connect(addr1).setApprovalForAll(stakeNftAddress, true);
    await stakeNft.connect(addr1).stake(1, 100);
    await ethers.provider.send('evm_increaseTime', [4 * 2628288]);
    await stakeNft.connect(addr1).unstake(1, 100);
    expect(await stakeNft.balanceOf(addr1.address)).to.not.equal(0);
  });

});
