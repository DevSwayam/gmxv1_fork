// SPDX-License-Identifier: MIT
// btc, wFtm, busd, wFtmscript/EntryPoint.sol

import {Script} from "forge-std/Script.sol";
import {PancakePair} from "../../../src/amm/PancakePair.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployPanCakePairForProtocol is Script {
    PancakePair _pancakePair;
    function run() external returns (address) {
        _pancakePair = new PancakePair();

        return (address(_pancakePair));
    }
}
