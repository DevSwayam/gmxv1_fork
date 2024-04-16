// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {WETH} from "../../src/tokens/WETH.sol";

pragma solidity ^0.6.12;

contract DeployNativeToken is Script{
    WETH _wEth;

    function run(string memory name, string memory symbol, uint8 decimals) external returns(WETH){
        _wEth = new WETH(name,symbol, decimals);
    }
}