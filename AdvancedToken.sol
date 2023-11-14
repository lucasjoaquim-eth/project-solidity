// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract AdvancedToken is ERC20, Ownable, Pausable {
    address public escrow;

    event EscrowChanged(address indexed newEscrow);

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        escrow = msg.sender;
    }

    function setEscrow(address newEscrow) external onlyOwner {
        escrow = newEscrow;
        emit EscrowChanged(newEscrow);
    }

    function transfer(address to, uint256 amount) public override whenNotPaused returns (bool) {
        require(to != address(0), "ERC20: transfer to the zero address is not allowed");
        require(!paused(), "Token transfers are currently paused");
        super.transfer(to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override whenNotPaused returns (bool) {
        require(to != address(0), "ERC20: transfer to the zero address is not allowed");
        require(!paused(), "Token transfers are currently paused");
        super.transferFrom(from, to, amount);
        return true;
    }
}
