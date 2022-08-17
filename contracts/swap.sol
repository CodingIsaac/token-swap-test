// SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "./testToken.sol";
import "./ISwapERC.sol";


contract Swapping {
    // IERC20 token1;
    // ERC20 createdToken;

    /**
     * determine the price per token
     * record in struct the foolowing
     * a. token address he wants to swap to
     * b. token address that want to receive the token
     * c. the amount he want to swap
     * d. mapping of the uint to struct
     * e. timestamp
     * 
     *
     */

    address owner; // creator of the inital token
    
    struct orderBook {
        uint tokenAmount; // Token amount to be swapped to
        address ofReceiver; // swappers receiving address
        address swapWith; // swappers normal address
        uint deadline; // time stamp should order take too long
        bool orderCancelled; // show true/false if swap was successful
        uint ownedToken; // the token I have to be swapped
        uint setTokenPrice; //value of token b
        uint priceUponToken;

        

        

        
    }

    // event Transfer(address indexed from, address indexed to, uint256 value);
    // event Approval(address indexed owner, address indexed spender, uint256 value);

    mapping (address => orderBook) public placeOrder;
    // mapping (uint => orderBook) tokenUpdate;

    constructor() {
        // token1 = IERC20(_token1);
        // createdToken = ERC20(_testToken);


        owner = msg.sender;
        
    }

    receive() external payable {

    } 

    fallback () external payable {

    }

    
    
    function swap (address _toowner, 
    address _ofReceiver, 
    address _swapWith, 
    uint _tokenAmount,
    uint _ownedToken, 
    uint _deadline,
    uint setTokenPrices,
    uint testTokenPath )
    external payable {
         orderBook storage to = placeOrder[msg.sender];
        require(msg.sender == _toowner || msg.sender == _swapWith, "Unauthorized Swap");
        require(to.tokenAmount > testTokenPath, "Insufficient Token");
        require(block.timestamp < _deadline, "Swap Impossibilia");
        
       
        to.tokenAmount = _tokenAmount;
        to.ofReceiver = _ofReceiver;
        to.swapWith = _swapWith;
        to.ownedToken = _ownedToken;
        to.deadline = block.timestamp + (_deadline);
        to.setTokenPrice = setTokenPrices;

        uint priceDetermination = setTokenPrice(to.priceUponToken, to.setTokenPrice );



        IERC20().transfer((msg.sender), to.ofReceiver, to.ownedToken);

        // emit Transfer(msg.sender, to.ofReceiver, to.ownedToken);

         


    }

    function setTokenPrice(uint ownersPrice, uint swappersPrice) private pure returns(uint swapper) {
        uint testTokenPrice = ERC20().pricePerToken;
        orderBook memory toSet = placeOrder[msg.sender];
        toSet.setTokenPrice = swappersPrice;

        // control flow to determine the price differenctiation

        swapper = testTokenPrice /  swappersPrice;
    }


    

    function approve(address tokenReleaser, 
    address tokenAddress, 
    uint amountTokenOne, 
    uint amountTokenTwo) 
    private returns(bool sent) {
        require(sent, "Swap failed");
    }

    

}
