// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/access/AccessControl.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/utils/Pausable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/utils/ReentrancyGuard.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * Minimal Chainlink AggregatorV3 interface
 */
interface AggregatorV3Interface {
    function decimals() external view returns (uint8);
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

/**
 * @title FxSettlement
 * @notice Thesis PoC settlement contract for FX swaps.
 * - Uses Chainlink-compatible oracles for pricing.
 * - Assumes BaseToken (SEUR) and QuoteToken (SUSD) share the same decimals (2).
 */
contract FxSettlement is AccessControl, Pausable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    bytes32 public constant TRADER_ROLE = keccak256("TRADER_ROLE");

    IERC20 public immutable baseToken;   // SEUR (Input)
    IERC20 public immutable quoteToken;  // SUSD (Output)

    AggregatorV3Interface public priceFeed;
    uint8 public feedDecimals;

    event TradeExecuted(
        address indexed trader,
        uint256 baseAmount,
        uint256 quoteAmount,
        int256 oraclePrice,
        uint256 timestamp
    );

    event PriceFeedUpdated(address indexed newFeed, uint8 decimals);
    event FundsWithdrawn(address indexed token, address indexed to, uint256 amount);

    constructor(
        address admin,
        address baseTokenAddress,
        address quoteTokenAddress,
        address priceFeedAddress
    ) {
        require(admin != address(0), "admin=0");
        require(baseTokenAddress != address(0), "base=0");
        require(quoteTokenAddress != address(0), "quote=0");
        require(priceFeedAddress != address(0), "feed=0");

        baseToken = IERC20(baseTokenAddress);
        quoteToken = IERC20(quoteTokenAddress);

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        
        // Granting TRADER_ROLE to admin simplifies testing/provisioning
        _grantRole(TRADER_ROLE, admin); 

        _setPriceFeed(priceFeedAddress);
    }

    // --- Admin controls ---

    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }

    function setPriceFeed(address newFeed) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _setPriceFeed(newFeed);
    }

    /**
     * @notice Allows the admin to withdraw funds (e.g., collected SEUR or remaining SUSD reserves).
     * @dev Critical function for liquidity management and rebalancing.
     */
    function withdraw(address token, uint256 amount) external onlyRole(DEFAULT_ADMIN_ROLE) {
        IERC20(token).safeTransfer(msg.sender, amount);
        emit FundsWithdrawn(token, msg.sender, amount);
    }

    function _setPriceFeed(address newFeed) internal {
        priceFeed = AggregatorV3Interface(newFeed);
        feedDecimals = priceFeed.decimals();
        emit PriceFeedUpdated(newFeed, feedDecimals);
    }

    // --- Oracle helper ---

    function getLatestPrice() public view returns (int256 price) {
        // Note: For production, 'updatedAt' must be checked to prevent stale data.
        // Omitted here for simplicity in the PoC context.
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return answer;
    }

    // --- Core trade execution ---

    /**
     * @notice Executes a SEUR -> SUSD exchange based on the current oracle price.
     */
    function executeTrade(uint256 baseAmount)
        external
        nonReentrant
        whenNotPaused
        onlyRole(TRADER_ROLE)
    {
        require(baseAmount > 0, "amount=0");

        int256 price = getLatestPrice();
        require(price > 0, "bad price");

        // Math: (Amount * Price) / 10^OracleDecimals
        // Valid only if baseToken.decimals == quoteToken.decimals (e.g., both are 2).
        uint256 quoteAmount = (baseAmount * uint256(price)) / (10 ** uint256(feedDecimals));
        require(quoteAmount > 0, "quote=0");

        // Liquidity Check
        require(quoteToken.balanceOf(address(this)) >= quoteAmount, "insufficient reserve");

        // 1. Pull SEUR from User
        baseToken.safeTransferFrom(msg.sender, address(this), baseAmount);

        // 2. Push SUSD to User
        quoteToken.safeTransfer(msg.sender, quoteAmount);

        emit TradeExecuted(msg.sender, baseAmount, quoteAmount, price, block.timestamp);
    }
}