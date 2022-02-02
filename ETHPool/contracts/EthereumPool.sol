// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@openzeppelin/contracts/access/Ownable.sol";

contract EthereumPool is Ownable {
    uint256 totalDeposit;

    mapping(address => uint256) addressToDeposits;

    function deposit_rewards() public onlyOwner {}

    function deposit_ETH() public {}

    function take_out_deposits() public {
        // require() que los fondos sean retirados por la address correcta.
    }

    function give_out_rewards() private {}
}
