// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library SafeMath {

    // Tambah
    function add(uint a, uint b) internal pure returns (uint c){
        return a + b;
    }
    
    // Kurang
    function sub(uint a, uint b) internal pure returns (uint c){
        return (a < b) ? (b - a) : (a - b);
    }

    // Bagi
    function div(uint a, uint b) internal pure returns (uint c){
        return a / b;
    }
    
    // Kali
    function mul(uint a, uint b) internal pure returns (uint c){
        return a * b;
    }
}