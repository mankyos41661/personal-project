// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "HarvestToken/Context.sol";

abstract contract Ownable is Context {
    address private owner = _msgSender();
    modifier onlyOwner(){
        require(owner == _msgSender(), "Owner: who are you?");
        _;
    }
}