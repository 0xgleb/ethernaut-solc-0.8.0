// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 6666666666666666666666666666666666666666666666666666666666666666
// 6666666666666666666666666666666666666666666666666666666666666666
// 412076657279207374726f6e67207365637265742070617373776f7264203a29

// 0x8bebD033677e38dF70A2798a2A83BE8BD55e93B5
// A very strong secret password :)
contract Vault {
    bool public locked;
    bytes32 private password;

    constructor(bytes32 _password) {
        locked = true;
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
            locked = false;
        }
    }
}

contract DeployerUpd {
    Vault public vault;
    bytes32 public _password =
        "\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66\x66";

    function deploy() public {
        vault = new Vault(_password);
    }
}

contract Unlock {
    function unlockVault() public {
        Vault vault = Vault(
            address(0x8bebD033677e38dF70A2798a2A83BE8BD55e93B5)
        );
        bytes32 _password = "A very strong secret password :)";
        vault.unlock(_password);
        require(!vault.locked());
    }
}
