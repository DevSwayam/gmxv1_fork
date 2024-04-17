// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {UniNftManager} from "../../../src/amm/UniNftManager.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployUniNftManager is Script{
    UniNftManager _uniNftManager;
   
   function run() external returns(address){
    //@dev please deploy contracts seperately for better readability
    _uniNftManager= new UniNftManager();
    return(address(_uniNftManager));
   }
}