// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {UniPool} from "../../../src/amm/UniPool.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployUniNftManager is Script{
    UniPool _uniPool;
   
   function run() external returns(address){
    //@dev please deploy contracts seperately for better readability
    _uniPool= new UniPool();
    return(address(_uniPool));
   }
}