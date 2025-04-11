// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    uint8 _decimals;
    constructor(string memory _name, string memory _symbol, uint8 tokenDecimals, uint256 _initialSupply, address _owner ) 
    ERC20(_name, _symbol) {
        _mint(msg.sender, _initialSupply);
        _decimals = tokenDecimals;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }
}