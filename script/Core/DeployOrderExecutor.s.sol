// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {OrderBook} from "../../src/core/OrderBook.sol";

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract DeployOrderExecutor is Script{

    OrderBook _orderBook;

    // @dev This returns intitalised OrderBook contract
    function run(address _routerAddress, address _vaultAddress, address _wethAddress, address _usdgAddress ) external returns (address){
        _orderBook = new OrderBook();
        uint256 minPurchaseTokenAmountInUsd = 10 * (10 ** 30);
        _orderBook.initialize(_routerAddress,_vaultAddress,_wethAddress,_usdgAddress,10000000000000000,minPurchaseTokenAmountInUsd);
        return(address(_orderBook));
    }
}
