// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {GlpManager} from "../../src/core/GlpManager.sol";

pragma solidity 0.6.12;

contract DeployGlpManager is Script{
    GlpManager glpManager;

    function run(address _vaultAddress, address _usdgAddress, address _nativeTokenAddress, address _shortsTracker,uint256 _coolDownDuration) external returns(GlpManager){
        // _coolDownDuration is = 15 * 60
        vm.startBroadcast();
        glpManager = new GlpManager(_vaultAddress,_usdgAddress,_nativeTokenAddress,_shortsTracker,_coolDownDuration);
        vm.stopBroadcast();
        return(glpManager);
    }
}