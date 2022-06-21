// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MoonToken is ERC20, Ownable {
    constructor() ERC20("MoonToken", "MOON") {}

    function mintToken(address sendTo, uint256 amountToSend) public onlyOwner {
        _mint(sendTo, amountToSend * 10 ** 18);
    }

    function burnToken(uint amount) external {
        _burn(msg.sender, amount);
    }
}
