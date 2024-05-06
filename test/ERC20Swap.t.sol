// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IPoolManager} from "uniswapv4/interfaces/IPoolManager.sol";
import {PoolManager} from "uniswapv4/PoolManager.sol";
import {ERC20Swap} from "../src/ERC20Swap.sol";

contract ERC20SwapTest is Test {
    ERC20Swap public erc20swap;

    function setUp() public {

        IPoolManager manager = new PoolManager(500000);
        erc20swap = new ERC20Swap(manager);
//        erc20swap.setNumber(0);

    }

    function test_Increment() public {
//        counter.increment();
//        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
//        counter.setNumber(x);
//        assertEq(counter.number(), x);
    }
}
