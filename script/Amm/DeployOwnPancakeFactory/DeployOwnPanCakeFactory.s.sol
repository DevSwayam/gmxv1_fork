// SPDX-License-Identifier: MIT
// btc, wFtm, busd, wFtmscript/EntryPoint.sol

import {Script} from "forge-std/Script.sol";
import {PancakeFactory} from "../PanCakeProtocol/PanCakeFactory.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployOwnPanCakeFactory is Script {
    PancakeFactory _pancakeFactory;

    function run(address _wEthAddress,
        address _wFtmAddress,
        address _wBtcAddress,
        address _busdAddress
    ) external returns (address, address, address, address, address) {
        _pancakeFactory = new PancakeFactory();

        address wFtmBusdPair = _pancakeFactory.createPair(_wFtmAddress, _busdAddress);
        address btcwFtmPair = _pancakeFactory.createPair(_wBtcAddress, _wFtmAddress);

        return (
            _wBtcAddress,
            _wFtmAddress,
            _busdAddress,
            wFtmBusdPair,
            btcwFtmPair
        );
    }
}
