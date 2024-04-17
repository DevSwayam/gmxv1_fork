// SPDX-License-Identifier: MIT
// btc, wFtm, busd, wFtmscript/EntryPoint.sol

import {Script} from "forge-std/Script.sol";
import {PancakeRouter} from "../../../src/amm/PancakeRouter.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployPanCakeRouters is Script {
    PancakeRouter _pancakeRouterForwFtmBusdPair;
    PancakeRouter _pancakeRouterForbtcwFtmPair;

    function run(address wFtmBusdPair,address btcwFtmPair ) external returns (address,address) {
        _pancakeRouterForwFtmBusdPair = new PancakeRouter(wFtmBusdPair);
        _pancakeRouterForbtcwFtmPair = new PancakeRouter(btcwFtmPair);
        return (address(_pancakeRouterForwFtmBusdPair),address(_pancakeRouterForbtcwFtmPair));
    }
}
