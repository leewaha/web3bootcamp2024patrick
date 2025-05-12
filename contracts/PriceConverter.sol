// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    
    function getPrice() internal  view returns(uint256){
        (,int256 price,,,)= AggregatorV3Interface( 0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
        // ETH|USD
        return uint256( price*1e10);// ? 十次方是什么精度,怎么计算的; feed.decimal 显示返回值的精度是8 .
    }   
 
    function getTheDecimal() internal view returns(uint8){
        return  AggregatorV3Interface( 0x694AA1769357215DE4FAC081bf1f309aDC325306).decimals();         
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256)  {
      // 1 ETH ?
      // 2000_1e18
        uint256 ethPrice = getPrice();
        // (2000_1e18 * 1_1e18) /1e18
        // $2000 = 1 ETH
        uint256 ethAmountInUsd= ( ethAmount * ethPrice)/1e18;
        return ethAmountInUsd;
    }
}
