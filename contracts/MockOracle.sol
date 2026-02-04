// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/access/Ownable.sol";

/**
 * @title MockOracle
 * @notice Chainlink-compatible mock aggregator for deterministic PoC tests.
 * Allows the owner to manually set the price to simulate specific market conditions.
 */
contract MockOracle is Ownable {
    int256 private _price;
    uint8 private _decimals;

    /**
     * @param decimals_ Standard Chainlink decimals (usually 8 for fiat pairs).
     * @param initialPrice The starting price (e.g. 105000000 for 1.05).
     * @param initialOwner The address that can update the price.
     */
    constructor(uint8 decimals_, int256 initialPrice, address initialOwner) Ownable(initialOwner) {
        require(initialPrice > 0, "price<=0"); // Safety check
        _decimals = decimals_;
        _price = initialPrice;
    }

    function decimals() external view returns (uint8) {
        return _decimals;
    }

    /**
     * @notice Updates the mock price.
     * @dev Only callable by the owner.
     */
    function setPrice(int256 newPrice) external onlyOwner {
        require(newPrice > 0, "price<=0");
        _price = newPrice;
    }

    // Standard Chainlink Interface implementation
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        // Return block.timestamp to simulate "fresh" data for the PoC verification
        return (
            1,                  // roundId (fake)
            _price,             // answer (THE PRICE)
            block.timestamp,    // startedAt
            block.timestamp,    // updatedAt
            1                   // answeredInRound (fake)
        );
    }
}