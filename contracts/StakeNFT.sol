// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract MoonToken is ERC20, Ownable, ERC1155Holder {
    IERC1155 public nft;

    struct stakeInfo{
        uint256 tokenStakedAt;
        uint256 stakeAmount; 
        address tokenOwner;
    }

    mapping(uint256 => stakeInfo) public stakeInfos;

    function getAPR(uint256 tokenId) public view returns(uint8){
        uint256 time = stakeInfos[tokenId].tokenStakedAt;

        if (block.timestamp - time < 30 days) {
            return 0;
        } else if (block.timestamp - time <  30 days * 6 ) {
            return 10;
        } else if (block.timestamp - time < 30 days * 12) {
            return 15;
        } else {
            return 25;
        }
    }

    constructor(address _nftAddress) ERC20("MoonToken", "MOON") {
        nft = IERC1155(_nftAddress);
    }

    function stakeNFT(uint256 tokenId, uint256 amount) external {
        nft.safeTransferFrom(msg.sender, address(this), tokenId, amount, "0");
    }

    function mintToken(address sendTo, uint256 amountToSend) public onlyOwner {
        _mint(sendTo, amountToSend * 10 ** 18);
    }

    function burnToken(uint amount) external {
        _burn(msg.sender, amount);
    }
}
