// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "./interfaces/IPancakeFactory.sol";

contract PancakeFactory is IPancakeFactory {
    address public btc;
    address public wFtm;
    address public busd;

    address public wFtmBusdPair;
    address public btcwFtmPair;

    constructor(address[5] memory _addresses) public {
        btc = _addresses[0];
        wFtm = _addresses[1];
        busd = _addresses[2];

        wFtmBusdPair = _addresses[3];
        btcwFtmPair = _addresses[4];
    }

    function getPair(address tokenA, address tokenB) external override view returns (address) {
        if (tokenA == busd && tokenB == wFtm) {
            return wFtmBusdPair;
        }
        if (tokenA == wFtm && tokenB == btc) {
            return btcwFtmPair;
        }
        revert("Invalid tokens");
    }
}
