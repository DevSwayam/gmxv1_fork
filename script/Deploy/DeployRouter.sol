// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {Router} from "../../src/core/Router.sol";

pragma solidity ^0.6.12;

contract DeployRouter is Script{
    Router router;

    function run(address _vaultAddress, address _usdgAddress, address _nativeTokenAddress) external returns(Router){
        vm.startBroadcast();
        router = new Router(_vaultAddress,_usdgAddress,_nativeTokenAddress);
        vm.stopBroadcast();
        return(router);
    }
}