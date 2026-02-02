// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

// OpenZeppelin imports via GitHub (works in Remix)
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/access/Ownable.sol";

/**
 * @title SEUR
 * @notice Mock ERC-20 token representing a synthetic EUR stablecoin for the thesis PoC.
 *         Owner can mint for test purposes.
 */
contract SEUR is ERC20, Ownable {
    constructor(address initialOwner) ERC20("Schaeffler EUR", "SEUR") Ownable(initialOwner) {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}