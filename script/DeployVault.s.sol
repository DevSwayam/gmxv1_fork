// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {Vault} from "../src/core/Vault.sol";

pragma solidity ^0.6.12;

contract DeployVault is Script{
    Vault vault;
    function run() external returns(Vault){
        vm.startBroadcast();
        vault = new Vault();
        vm.stopBroadcast();
        return(vault);
    }
}