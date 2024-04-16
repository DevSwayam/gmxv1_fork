// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {VaultPriceFeed} from "../../src/core/VaultPriceFeed.sol";


pragma solidity ^0.6.12;

contract DeployVaultPriceFeed is Script{

    VaultPriceFeed _vaultPriceFeed;


    function run() external returns(VaultPriceFeed){
        vm.startBroadcast();

        _vaultPriceFeed = new VaultPriceFeed();

        vm.stopBroadcast();
        return(_vaultPriceFeed);
    }
}