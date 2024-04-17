// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {Timelock} from "../../src/peripherals/TimeLock.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployTimelock is Script{
    Timelock _timelock;
   
   function run() external returns(address){
    //@dev need to work on this after glp managers
    return(address(0x0));
   }
}