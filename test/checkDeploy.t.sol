// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {DeployVault} from "../script/Core/DeployVault.s.sol";
import {Test, console} from "forge-std/Test.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract TestDeployVault is Test{

    DeployVault _deployVault;

    function setUp() external {
        _deployVault = new DeployVault();
        console.log(address(_deployVault));
    }
}