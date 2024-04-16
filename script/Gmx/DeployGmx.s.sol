// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {GMX} from "../../src/gmx/GMX.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployGmx is Script{
    GMX _gmx;
   
   function run() external returns(address){
    //@dev please deploy contracts seperately for better readability
    _gmx = new GMX();
    return(address(_gmx));
   }
}