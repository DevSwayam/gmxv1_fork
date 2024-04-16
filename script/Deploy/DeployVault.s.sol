// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {Vault} from "../../src/core/Vault.sol";
import {USDG} from "../../src/tokens/USDG.sol";
import {Router} from "../../src/core/Router.sol";
import {WETH} from "../../src/tokens/WETH.sol";

pragma solidity ^0.6.12;

contract DeployVault is Script{

    Vault _vault;
    USDG _usdg;
    Router _router;
    WETH _wEth;
    
    function run() external returns(Vault){
        vm.startBroadcast();

        //Deploying USDG Contract
        _vault = new Vault();

        // Deploying USDG contract
        _usdg = new USDG(address(_vault));

        //Deploying Weth as a Native Token
        _wEth = new WETH("Wrapped Eth","WETH", 18);

        // Deploying Router contract for users
        _router = new Router(address(_vault),address(_usdg), address(_wEth));
       
        vm.stopBroadcast();
        return(_vault);
    }
}