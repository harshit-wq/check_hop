pragma solidity ^0.7.0;

/**
 * @title Hop.
 * @dev Inter Chain Bridge.
 */

import { TokenInterface } from "../../common/interfaces.sol";
import { Helpers } from "./helpers.sol";
import { Basic } from "../../common/basic.sol";
import { Events } from "./events.sol";

abstract contract HopResolver is Helpers, Events {
	/**
	 * @dev Bridge Token.
	 * @notice Bridge Token on HOP.
	 * @param token The address of token to be bridged.(For USDC: 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174)
	 * @param chainId The Id of the destination chain.(For MAINET : 1)
	 * @param recipient The address to recieve the token on destination chain.
	 * @param amount The total amount sent by user (Includes bonder fee, destination chain Tx cost).
	 * @param bonderFee The fee to be recieved by bonder at destination chain.
     * @param amountOutMin will give description
     * @param deadline The deadline for the transaction (Recommended - Date.now() + 604800 (1 week))
     * @param destinationAmountOutMin will give description
     * @param destinationDeadline The deadline for the transaction (Recommended - Date.now() + 604800 (1 week))
	 * @param getId ID to retrieve amtA.
	 * @param setId ID stores the amount of pools tokens received.
	 */
    function bridge(        
        address token,
        uint256 chainId, 
        address recipient, 
        uint256 amount, 
        uint256 bonderFee, 
        uint256 amountOutMin, 
        uint256 deadline, 
        uint256 destinationAmountOutMin, 
        uint256 destinationDeadline,
		uint256 getId,
		uint256 setId
    )   
		external
		payable
		returns (string memory _eventName, bytes memory _eventParam)
    {
        uint256 _amt = getUint(getId, amount);

        _swapAndSend(
            token, 
            chainId, 
            recipient, 
            amount, 
            bonderFee, 
            amountOutMin, 
            deadline, 
            destinationAmountOutMin, 
            destinationDeadline
        );

        setUint(setId, 0); // The transaction will burn the amount on this chain, so this shpuld be zero right?

		_eventName = "LogBridge(address,uint256,address,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)";
		_eventParam = abi.encode(
            token,
            chainId,
            recipient,
            amount,
            bonderFee,
            amountOutMin,
            deadline,
            destinationAmountOutMin,
            destinationDeadline,
            getId,
            setId
		);


    }
}

contract ConnectV2Hop is HopResolver {
	string public constant name = "Hop-v1.0";
}