
// SPDX-License-Identifier: MIT
// btc, wFtm, busd, wFtmscript/EntryPoint.sol

import {Script} from "forge-std/Script.sol";
import {WETH} from "../../src/tokens/WETH.sol";
import {ERC20Token} from "./ERC20Token.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployTokens is Script{
    WETH _wEth;
    ERC20Token _wFtm;
    ERC20Token _wBtc;
    ERC20Token _busd;

   function run() external returns(address,address,address,address){

    _wEth = new WETH("Wrapped Eth","WETH", 18);
    _wFtm = new ERC20Token("Wrapped Fantom","_wFtm", 18);
    _wBtc = new ERC20Token("Wrapped Bitcoin","_wBtc", 18);
    _busd = new ERC20Token("B USD","_busd", 18);

    return(address(_wEth),address(_wFtm),address(_wBtc),address(_busd));
   }
}