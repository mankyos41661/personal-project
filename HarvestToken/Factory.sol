// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
pragma abicoder v2;

import "HarvestToken/Harvest.sol";
import "HarvestToken/Ownable.sol";
import "HarvestToken/IERC20.sol";

contract Factory is Ownable {
    // Object
    // Harvest internal harvest = new Harvest();

    function deploy(
        IERC20 _harvestToken,
        Harvest _harvestedToken,
        uint _amount,
        uint _rewardPerBlock
    ) public onlyOwner {
        /*
        bytes memory bytecode = abi.encode(_harvestToken);
        bytes32 salt = keccak256(abi.encodePacked(_harvestToken, _amount, _rewardPerBlock));
        address harvesting;
        assembly {
            harvesting := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        
        Harvest(_harvestToken).initialize(
            _harvestToken,
            _amount,
            _rewardPerBlock
        );
        */
        _harvestToken.call(abi.encodeWithSignature("initialize()"););
    }

}