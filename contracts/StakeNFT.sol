// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract StakeNFT is ERC20, Ownable, ERC1155Holder {
    IERC1155 public nft;

    struct stakeInfo{
        uint256 tokenStakedAt;
        uint256 stakeAmount; 
        address tokenOwner;
        bool isNFTStaked;
    }

    mapping(uint256 => stakeInfo) public stakeInfos;

    function getAPR(uint256 tokenId) public view returns(uint8){
        uint256 stakeTime = stakeInfos[tokenId].tokenStakedAt;

        if (block.timestamp - stakeTime < 30 days) {
            return 0;
        } else if (block.timestamp - stakeTime <  30 days * 6 ) {
            return 10;
        } else if (block.timestamp - stakeTime < 30 days * 12) {
            return 15;
        } else {
            return 25;
        }
    }

    constructor(address _nftAddress) ERC20("MoonToken", "MOON") {
        nft = IERC1155(_nftAddress);
    }

    function stake(uint256 tokenId, uint256 amount) external {
        require(nft.balanceOf(msg.sender, tokenId) >= amount, "You don't have enough balance to stake");
        nft.safeTransferFrom(msg.sender, address(this), tokenId, amount, "0x00");
        stakeInfos[tokenId] = stakeInfo(block.timestamp, amount, msg.sender, true);
    }

    function calculateTokens(uint256 tokenId, uint256 amount) public view returns (uint256){
        stakeInfo memory readStakeInfo = stakeInfos[tokenId];
        require(readStakeInfo.isNFTStaked == true, "NFT is not staked yet");
        uint256 stakedTime = block.timestamp - readStakeInfo.tokenStakedAt;
        return getAPR(tokenId) * stakedTime * amount * 10 ** 18 /  (30 days * 12 * 100) ;
    } 

    function unstake(uint256 tokenId, uint256 amount) external {
        require(stakeInfos[tokenId].tokenOwner == msg.sender, "You can't unstake as you are not a owner");
        stakeInfos[tokenId].stakeAmount -= amount;
        stakeInfos[tokenId].isNFTStaked = false;
        _mint(msg.sender, calculateTokens(tokenId, amount));
        nft.safeTransferFrom(address(this), msg.sender, tokenId, amount, "0x00");
    }

    function burnToken(uint amount) external {
        _burn(msg.sender, amount);
    }
}
