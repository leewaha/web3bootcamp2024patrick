// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {FundMe} from "../src/FundMe.sol";
import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    FundMe fundMe;
    HelperConfig helperConfig;

    function run() external returns (FundMe) {
        // This function is called before the real function
        helperConfig = new HelperConfig();
        address net_node = helperConfig.activeNetworkConfig();

        // broadcast the transaction ,it's real transaction
        vm.startBroadcast();
        fundMe = new FundMe(net_node);
        vm.stopBroadcast();
        return fundMe;
    }
}
