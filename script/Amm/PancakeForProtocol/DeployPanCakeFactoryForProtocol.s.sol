// SPDX-License-Identifier: MIT
// btc, wFtm, busd, wFtmscript/EntryPoint.sol

import {Script} from "forge-std/Script.sol";
import {PancakeFactory} from "../../../src/amm/PancakeFactory.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployPanCakeFactoryForProtocol is Script {
    PancakeFactory _panCakefactory;
    function run(
        address _wBtcAddress,
        address _wFtmAddress,
        address _busdAddress,
        address wFtmBusdPair,
        address btcwFtmPair
    ) external returns (address) {
        _panCakefactory = new PancakeFactory(
            [
                _wBtcAddress,
                _wFtmAddress,
                _busdAddress,
                wFtmBusdPair,
                btcwFtmPair
            ]
        );

        return (address(_panCakefactory));
    }
}
