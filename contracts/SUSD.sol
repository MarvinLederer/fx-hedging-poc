// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

// OpenZeppelin imports via GitHub
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/access/Ownable.sol";

/**
 * @title SUSD (Schaeffler USD)
 * @notice Mock ERC-20 token representing a synthetic USD stablecoin for the thesis PoC.
 * Owner can mint for test purposes.
 */
contract SUSD is ERC20, Ownable {
    constructor(address initialOwner)
        ERC20("Schaeffler Dollar", "SUSD")
        Ownable(initialOwner)
    {}

    function decimals() public view virtual override returns (uint8) {
        return 2;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}