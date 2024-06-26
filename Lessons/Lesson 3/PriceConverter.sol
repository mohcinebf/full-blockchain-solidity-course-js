// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function getRoundData(
    uint80 _roundId
    ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

    function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

library PriceConverter{

function getPrice() internal view returns(uint256){
        // ETH/USD Address in Sepolia Network 0x694AA1769357215DE4FAC081bf1f309aDC325306
        address eth_usd = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        AggregatorV3Interface priceFeed = AggregatorV3Interface(eth_usd);
        (, int price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);

    }
    function getVersion() internal view returns (uint256){
        address eth_usd = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        AggregatorV3Interface priceFeed = AggregatorV3Interface(eth_usd);
        return priceFeed.version();
    }
    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e36;
        return ethAmountInUsd;
    }

}