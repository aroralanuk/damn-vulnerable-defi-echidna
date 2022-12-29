// pragma solidity ^0.8.0;

// import "./NaiveReceiverLenderPool.sol";
// import "./FlashLoanReceiver.sol";
// // import "@openzeppelin/contracts/utils/Address.sol";

// contract NaiveReceiverEchidna {
//     NaiveReceiverLenderPool public pool;
//     FlashLoanReceiver public target;

//     constructor() {
//         pool = new NaiveReceiverLenderPool();
//         target = new FlashLoanReceiver(payable(address(pool)));

//         payable(address(pool)).send(1000 ether);
//         payable(address(target)).send(10 ether);
//     }

//     function echidna_testBalance() public returns (bool) {
//         return address(target).balance >= 10 ether;
//     }
// }


pragma solidity ^0.8.0;

import "./NaiveReceiverLenderPool.sol";
import "./FlashLoanReceiver.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract NaiveReceiverEchidna {
    using Address for address payable;

    // We will send ETHER_IN_POOL to the flash loan pool.
    uint256 constant ETHER_IN_POOL = 1000e18;
    // We will send ETHER_IN_RECEIVER to the flash loan receiver.
    uint256 constant ETHER_IN_RECEIVER = 10e18;

    NaiveReceiverLenderPool pool;
    FlashLoanReceiver receiver;

    // Setup echidna test by deploying the flash loan pool and receiver and sending them some ether.
    constructor() payable {
        pool = new NaiveReceiverLenderPool();
        receiver = new FlashLoanReceiver(payable(address(pool)));
        payable(address(pool)).sendValue(ETHER_IN_POOL);
        payable(address(receiver)).sendValue(ETHER_IN_RECEIVER);
    }

    // We want to test whether the balance of the receiver contract can be decreased.
    function echidna_test_contract_balance() public view returns (bool) {
        return address(receiver).balance >= 10 ether;
    }
}
