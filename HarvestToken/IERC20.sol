// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function transferAndCall(address to, uint value, bytes calldata data) external returns (bool);
    function transferFromAndCall(address from, address to, uint value) external returns (bool);
    function transferFromAndCall(address from, address to, uint value, bytes calldata data) external returns (bool);
    function approveAndCall(address spender, uint value) external returns (bool);
    function approveAndCall(address spender, uint value, bytes calldata data) external returns (bool);
    function supportInterface(bytes4 interfaceID) external view returns (bool);
}
