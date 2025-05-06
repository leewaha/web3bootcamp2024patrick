// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract HelperConfig {
    struct NetworkConfig {
        address priceFeed;
    }

    NetworkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = NetworkConfig({
                priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
            });
        } else {
            revert("No valid network found");
        }
    }
}
