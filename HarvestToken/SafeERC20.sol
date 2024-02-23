// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "HarvestToken/Address.sol";
import "HarvestToken/IERC20.sol";

library SafeERC20 {
    using Address for address;

    // Output: Error
    error SafeERC20FailedOperation(address token);
    error SafeERC20FailedDecreaseAllowance(address spender, uint currentAllowance, uint requestedDecrease);

    // Write: Transfer
    function safeTransfer(IERC20 token, address to, uint value) internal {
        _callOptionalReturn(token, abi.encodeCall(token.transfer, (to, value)));
    }

    // Write: Transfer From
    function safeTransferFrom(IERC20 token, address from, address to, uint value) internal {
        _callOptionalReturn(token, abi.encodeCall(token.transferFrom, (from, to, value)));
    }

    // Write: Increase Allowance
    function safeIncreaseAllowance(IERC20 token, address spender, uint value) internal {
        uint oldAllowance = token.allowance(address(this), spender);
        forceApprove(token, spender, oldAllowance + value);
    }

    // Write: Decrease Allowance
    function safeDecreaseAllowance(IERC20 token, address spender, uint requestedDecrease) internal {
        unchecked {
            uint currentAllowance = token.allowance(address(this), spender);
            if (currentAllowance < requestedDecrease){
                revert SafeERC20FailedDecreaseAllowance(spender, currentAllowance, requestedDecrease);
            }
            forceApprove(token, spender, currentAllowance - requestedDecrease);
        }
    }

    // Write: Approval
    function forceApprove(IERC20 token, address spender, uint value) internal {
        bytes memory approvalCall = abi.encodeCall(token.approve, (spender, value));

        if (!_callOptionalReturnBool(token, approvalCall)){
            _callOptionalReturn(token, abi.encodeCall(token.approve, (spender, 0)));
            _callOptionalReturn(token, approvalCall);
        }
    }

    // Write: Transfer & Call Relax
    function transferAndCallRelaxed(IERC20 token, address to, uint256 value, bytes memory data) internal {
        if (to.code.length == 0) {
            safeTransfer(token, to, value);
        } else if (!token.transferAndCall(to, value, data)) {
            revert SafeERC20FailedOperation(address(token));
        }
    }

    // Write: Transfer From & Call Relax
    function transferFromAndCallRelaxed(
        IERC20 token,
        address from,
        address to,
        uint256 value,
        bytes memory data
    ) internal {
        if (to.code.length == 0) {
            safeTransferFrom(token, from, to, value);
        } else if (!token.transferFromAndCall(from, to, value, data)) {
            revert SafeERC20FailedOperation(address(token));
        }
    }

    // Write: Approval & Call Relax
    function approveAndCallRelaxed(IERC20 token, address to, uint value, bytes memory data) internal {
        if (to.code.length == 0){
            forceApprove(token, to, value);
        } else if (!token.approveAndCall(to, value, data)){
            revert SafeERC20FailedOperation(address(token));
        }
    }

    // Call: Optional Return
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        bytes memory returndata = address(token).functionCall(data);
        if (returndata.length != 0 && !abi.decode(returndata, (bool))){
            revert SafeERC20FailedOperation(address(token));
        }
    }

    // Call: Optional Return with Boolean
    function _callOptionalReturnBool(IERC20 token, bytes memory data) private returns (bool) {
        (bool success, bytes memory returndata) = address(token).call(data);
        return success && (returndata.length == 0 || abi.decode(returndata, (bool))) && address(token).code.length > 0;
    }
}