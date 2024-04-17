// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {UniFactory} from "../../../src/amm/UniFactory.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployUniNftManager is Script{
    UniFactory _uniFactory;
   
   function run() external returns(address){
    //@dev please deploy contracts seperately for better readability
    _uniFactory= new UniFactory();
    return(address(_uniFactory));
   }
}