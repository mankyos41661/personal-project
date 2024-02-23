// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "HarvestToken/SafeERC20.sol";
import "HarvestToken/Context.sol";

contract Harvest is Context {
    using SafeERC20 for IERC20;

    // Declaration
    uint public rewardPerBlock;
    uint public multiplier;
    uint public balancePool;
    IERC20 public harvestToken;

    // Metadata
    string internal name_ = "Harvest Token";
    string internal symbols_ = "HTKN";
    uint8 internal decimals_ = 18;

    // Pool
    mapping(address => uint) internal balanceOf;

    // Init
    function initialize(IERC20 _harvestToken /*Your address token*/, uint _amount, uint _rewardPerBlock) external {
        harvestToken = _harvestToken;
        rewardPerBlock = _rewardPerBlock;
        
        _mint(_amount);
    }

    // Read: Metadata
    function name() public view returns (string memory){
        return name_;
    }

    function symbols() public view returns (string memory){
        return symbols_;
    }

    function decimals() public view returns (uint8){
        return decimals_;
    }

    function pool() public view returns (uint){
        return balancePool;
    }

    // Write: Withdraw
    function withdraw() external {
        _updateBalance();
        // harvestToken.safeTransferFrom(_dis(), _msgSender(), pool());
        _msgSender().call(abi.encodeWithSignature("harvestToken.safeTransferFrom(_dis(), _msgSender(), pool())"));
        _updatePool();
    }

    // Write: Reward
    function changeRewardPerBlock(uint _rewardPerBlock) external {
        rewardPerBlock = _rewardPerBlock;
        _updatePool();
    }

    function increaseRewardPerBlock(uint _increase) external {
        rewardPerBlock += _increase;
    }

    function decreaseRewardPerBlock(uint _decrease) external {
        require(rewardPerBlock < _decrease, "Contract: can not decrease reward");
        rewardPerBlock -= _decrease;
    }

    // Write: Multiplier
    function changeMultiplier(uint _multiply) external {
        multiplier = _multiply;
    }

    function increaseMultiplier(uint _increase) external {
        multiplier += _increase;
    }

    function decreaseMultiplier(uint _decrease) external {
        require(multiplier > _decrease, "Contract: can not decrease multiplier");
        multiplier -= _decrease;
    }

    // Write: Update
    function _updatePool() internal {
        balancePool += block.number * rewardPerBlock * 2; // number of block * reward per block * multiplier
    }

    function _updateBalance() internal {
        _updatePool();
        balanceOf[_dis()] = balancePool;
    }

    // Write: Mint
    function mintPool(uint amount) external {
        _mint(amount);
    }

    function _mint(uint amount) internal {
        balancePool += amount;
    }
}