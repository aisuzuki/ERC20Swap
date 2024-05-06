// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IPoolManager} from "uniswapv4/interfaces/IPoolManager.sol";
import {PoolManager} from "uniswapv4/PoolManager.sol";
import { PoolKey } from "uniswapv4/types/PoolKey.sol";
import { CurrencyLibrary, Currency } from "uniswapv4/types/Currency.sol";
import {IHooks} from "uniswapv4/interfaces/IHooks.sol";
import {PoolId, PoolIdLibrary} from "uniswapv4/types/PoolId.sol";
import {LPFeeLibrary} from "uniswapv4/libraries/LPFeeLibrary.sol";
import {TickMath} from "uniswapv4/libraries/TickMath.sol";
import {Constants} from "uniswapv4test/utils/Constants.sol";
import {Deployers} from "uniswapv4test/utils/Deployers.sol";
import {ERC20Swap} from "../src/ERC20Swap.sol";

contract ERC20SwapTest is Test, Deployers {
    using PoolIdLibrary for PoolKey;
    using LPFeeLibrary for uint24;
    using CurrencyLibrary for Currency;

    ERC20Swap public erc20swap;

    event Swap(
        PoolId indexed poolId,
        address sender,
        int128 amount0,
        int128 amount1,
        uint160 sqrtPriceX96,
        uint128 liquidity,
        int24 tick,
        uint24 fee
    );

    function setUp() public {
        initializeManagerRoutersAndPoolsWithLiq(IHooks(address(0)));
        erc20swap = new ERC20Swap(manager);
    }

    function test_Swap() public {

        IPoolManager.SwapParams memory swapParams =
            IPoolManager.SwapParams({zeroForOne: true, amountSpecified: -100, sqrtPriceLimitX96: SQRT_RATIO_1_2});

        ERC20Swap.TestSettings memory testSettings =
            ERC20Swap.TestSettings({takeClaims: true, settleUsingBurn: false});

        vm.expectEmit(true, true, true, true);
        emit Swap(
            nativeKey.toId(),
            address(erc20swap),
            int128(-100),
            int128(98),
            79228162514264329749955861424,
            1e18,
            -1,
            3000
        );

        erc20swap.swap{value: 100}(nativeKey, swapParams, testSettings, ZERO_BYTES);
    }

}
