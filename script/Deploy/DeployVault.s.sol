// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {Vault} from "../../src/core/Vault.sol";
import {USDG} from "../../src/tokens/USDG.sol";
import {Router} from "../../src/core/Router.sol";
import {WETH} from "../../src/tokens/WETH.sol";
import {VaultPriceFeed} from "../../src/core/VaultPriceFeed.sol";
import {GLP} from "../../src/gmx/GLP.sol";
import {GlpManager} from "../../src/core/GlpManager.sol";
import {ShortsTracker} from "../../src/core/ShortsTracker.sol";
import {VaultErrorController} from "../../src/core/VaultErrorController.sol";
import {VaultUtils} from "../../src/core/VaultUtils.sol";

pragma solidity 0.6.12;

contract DeployVault is Script{

    Vault _vault;
    USDG _usdg;
    Router _router;
    WETH _wEth;
    VaultPriceFeed _vaultPriceFeed;
    GLP _glp;
    ShortsTracker _shortsTracker;
    GlpManager _glpManager;
    VaultErrorController _vaultErrorController;
    VaultUtils _vaultUtils;
    string[56] _errors = [
      "Vault: zero error",
      "Vault: already initialized",
      "Vault: invalid _maxLeverage",
      "Vault: invalid _taxBasisPoints",
      "Vault: invalid _stableTaxBasisPoints",
      "Vault: invalid _mintBurnFeeBasisPoints",
      "Vault: invalid _swapFeeBasisPoints",
      "Vault: invalid _stableSwapFeeBasisPoints",
      "Vault: invalid _marginFeeBasisPoints",
      "Vault: invalid _liquidationFeeUsd",
      "Vault: invalid _fundingInterval",
      "Vault: invalid _fundingRateFactor",
      "Vault: invalid _stableFundingRateFactor",
      "Vault: token not whitelisted",
      "Vault: _token not whitelisted",
      "Vault: invalid tokenAmount",
      "Vault: _token not whitelisted",
      "Vault: invalid tokenAmount",
      "Vault: invalid usdgAmount",
      "Vault: _token not whitelisted",
      "Vault: invalid usdgAmount",
      "Vault: invalid redemptionAmount",
      "Vault: invalid amountOut",
      "Vault: swaps not enabled",
      "Vault: _tokenIn not whitelisted",
      "Vault: _tokenOut not whitelisted",
      "Vault: invalid tokens",
      "Vault: invalid amountIn",
      "Vault: leverage not enabled",
      "Vault: insufficient collateral for fees",
      "Vault: invalid position.size",
      "Vault: empty position",
      "Vault: position size exceeded",
      "Vault: position collateral exceeded",
      "Vault: invalid liquidator",
      "Vault: empty position",
      "Vault: position cannot be liquidated",
      "Vault: invalid position",
      "Vault: invalid _averagePrice",
      "Vault: collateral should be withdrawn",
      "Vault: _size must be more than _collateral",
      "Vault: invalid msg.sender",
      "Vault: mismatched tokens",
      "Vault: _collateralToken not whitelisted",
      "Vault: _collateralToken must not be a stableToken",
      "Vault: _collateralToken not whitelisted",
      "Vault: _collateralToken must be a stableToken",
      "Vault: _indexToken must not be a stableToken",
      "Vault: _indexToken not shortable",
      "Vault: invalid increase",
      "Vault: reserve exceeds pool",
      "Vault: max USDG exceeded",
      "Vault: reserve exceeds pool",
      "Vault: forbidden",
      "Vault: forbidden",
      "Vault: maxGasPrice exceeded"
    ];  

    function run() external returns(Vault){
        vm.startBroadcast();

        //Deploying USDG Contract
        _vault = new Vault();

        // Deploying USDG contract
        _usdg = new USDG(address(_vault));

        //Deploying Weth as a Native Token
        _wEth = new WETH("Wrapped Eth","WETH", 18);

        // Deploying Router contract for users
        _router = new Router(address(_vault),address(_usdg), address(_wEth));

        _vaultPriceFeed = new VaultPriceFeed();

        // Setting up the params for VaultPriceFeed
        uint256 price = 1 * 10**28;
        _vaultPriceFeed.setMaxStrictPriceDeviation(price);
        _vaultPriceFeed.setPriceSampleSpace(1);
        _vaultPriceFeed.setIsAmmEnabled(false);

        // Deploying Shorts Tracker
        _shortsTracker = new ShortsTracker(address(_vault));

        // Deploying GLP token 
        _glp = new GLP();
        _glp.setInPrivateTransferMode(true);
        _glpManager = new GlpManager(address(_vault), address(_usdg),address(_glp),address(_shortsTracker),15*60);

        // Setting the minter for Glp token
        _glp.setMinter(address(_glpManager), true);

        //Adding vault to USDG token for minting usdg when someone puts collateral 
        _usdg.addVault(address(_glpManager));

        uint256 liquidationFee = 2000000000000000000000;
        _vault.initialize(
            address(_router), // router
            address(_usdg), // usdg
            address(_vaultPriceFeed), // priceFeed
            liquidationFee, // liquidationFeeUsd
            100, // fundingRateFactor
            100 // stableFundingRateFactor
          );
        
        _vault.setFundingRate(60 * 60, 100, 100);
        _vault.setInManagerMode(true);
       _vault.setManager(address(_glpManager), true);
      
        _vault.setFees(
          10, // _taxBasisPoints
          5, // _stableTaxBasisPoints
          20, // _mintBurnFeeBasisPoints
          20, // _swapFeeBasisPoints
          1, // _stableSwapFeeBasisPoints
          10, // _marginFeeBasisPoints
          liquidationFee, // _liquidationFeeUsd
          24 * 60 * 60, // _minProfitTime
          true // _hasDynamicFees
        );

        _vaultErrorController = new VaultErrorController();
        _vault.setErrorController(address(_vaultErrorController));

        // @dev while migration use Vault error contract 
        // @dev solidity 0.6.12 does not support nested array as a memory or as a argument so hence for loop has been used
        //Vault error controllers which will throw errors        
        for (uint256 i = 0; i < _errors.length; i++) {
          _vault.setError(i, _errors[i]);
        }  

        _vaultUtils = new VaultUtils(_vault);
        _vault.setVaultUtils(_vaultUtils);

        vm.stopBroadcast();
        return(_vault);
    }
}