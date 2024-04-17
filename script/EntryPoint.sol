// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {DeployVault} from "./Core/DeployVault.s.sol";
import {WETH} from "../src/tokens/WETH.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract EntryPoint is Script{
   DeployVault _vault;
   function run() external {
    //@dev please deploy contracts seperately for better readability  
      _vault = new DeployVault();
   }
}