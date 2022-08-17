// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract testToken is ERC20, Ownable {
    uint256 public constant pricePerToken = 2 * 10;
    uint public constant TotalSUpply = 1000000;
    uint decimal;
   


    constructor() ERC20("Test Token", "TET") {
         decimal = 6;

         _mint(address(this), 1000000);
    }

    


   
}
