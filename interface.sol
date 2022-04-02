pragma solidity ^0.7.0;

interface IHopRouter {

    function swapAndSend(
        uint256 chainId, 
        address recipient, 
        uint256 amount, 
        uint256 bonderFee, 
        uint256 amountOutMin, 
        uint256 deadline, 
        uint256 destinationAmountOutMin, 
        uint256 destinationDeadline
    )   
        external; 
    
}