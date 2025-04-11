// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import { Token } from "./Token.sol";

/**
 * @title ERC20 Token Factory
 * @author @0xCodeKaito
 * @notice Contract for creating and deploying new ERC20 tokens
 * @notice The configuration consist of:
 *  - Token name
 *  - Token symbol
 *  - Token decimals
 *  - Token initial supply
 *  - Token owner
 *  - Token minter
 * @dev This contract allows users to deploy new ERC20 token contracts with customizable parameters
 */

contract TokenFactory {
    constructor() {}

    event TokenCreated(address tokenAddress);
    
    function createToken(string memory name, string memory symbol, uint8 decimals, uint256 initialSupply) public {
        Token newToken = new Token(name,symbol,decimals,100 * 10 ** decimals);
        emit TokenCreated(address(newToken));
    }
}