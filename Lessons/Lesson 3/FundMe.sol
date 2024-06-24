// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;
    
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable{
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw () public onlyowner{

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            // set the amount 0 for every funder
            addressToAmountFunded[funders[funderIndex]] = 0;
        }
        // rest the array
        funders = new address[](0);
        //withdraw the funds
        (bool success,) = payable (msg.sender).call{value: address(this).balance}("");
        require(success, "call failed");
    }

    modifier onlyowner {
        require(msg.sender == i_owner, "Sender is not owner!");
        _;
    }
    
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    
}