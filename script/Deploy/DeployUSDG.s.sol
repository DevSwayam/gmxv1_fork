// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {USDG} from "../../src/tokens/USDG.sol";

pragma solidity ^0.6.12;

contract DeployUSDG is Script{
    USDG usdg;

    function run(address _vault) external returns(USDG){
        vm.startBroadcast();
        usdg = new USDG(_vault);
        vm.stopBroadcast();
        return(usdg);
    }
}