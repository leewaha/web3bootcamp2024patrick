// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";


contract FundMe{
    // 将公共方法提取到库中,指定库适用数据类型
    using PriceConverter for uint256; 
    uint256 constant public minimumUsd =5e18;// 限定最小的支付金额
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    address public immutable i_owner;

    constructor(){
        i_owner=msg.sender;
    }

    function fund() public payable{
        // (,int256 rate,,,)=    dataFeed.latestRoundData();
        // rate/= 0.1e18;
        require(msg.value.getConversionRate()>=minimumUsd , "didn't send money less 1ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]+=msg.value;
        // addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner {
       // require(msg.sender==owner,"Only owner can withdraw");
        for (uint256 funderIndex=0; funderIndex<funders.length ; funderIndex++) 
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }

        //reset funders
        funders=new address[](0);
        //withdraw the fund
        /**
        * transfer (2300 gas, throws error)
        * send (2300 gas, returns bool)
        * call (forward all gas or set gas, returns bool)
        */
        // //transfer
        // payable (  msg.sender).transfer(address(this).balance);
        // //send
        //   bool transSucc= payable (  msg.sender).send(address(this).balance);
        //   require(transSucc,"withdraw send fail");
        //call
        (bool callSuccess, ) = payable (  msg.sender).call{value: address(this).balance}("");
         require(callSuccess,"withdraw call fail");
    }

 
    modifier onlyOwner{
    require(msg.sender==i_owner,"Only owner can withdraw");
    _;
    }

}