// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

//import "@openzeppelin/contracts/access/Ownable.sol";

contract EthereumPool {
    event EthDeposited(address _from, uint256 _amount);

    address public owner;

    uint256 totalDeposit;
    address[] public depositors;

    mapping(address => uint256) addressToDeposits;
    mapping(address => uint256) addressToPoolParticipation;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function deposit_rewards() public payable onlyOwner {
        distribute_rewards(msg.value);
    }

    function deposit_ETH() public payable {
        if (!isDepositor(msg.sender)) {
            depositors.push(msg.sender);
        }
        totalDeposit += msg.value;
        addressToDeposits[msg.sender] += msg.value;
        emit EthDeposited(msg.sender, msg.value);
        updateDataBase();
    }

    function withdraw_deposits() public payable {
        require(
            addressToDeposits[msg.sender] >= msg.value,
            "You must deposit some Ether in order to withdraw."
        );
        msg.sender.transfer(
            (addressToPoolParticipation[msg.sender] * address(this).balance) /
                10000
        );
        addressToDeposits[msg.sender] -= msg.value;
        totalDeposit -= msg.value;
        updateDataBase();
    }

    function updateDataBase() private {
        for (uint256 i = 0; i < depositors.length; i++) {
            addressToPoolParticipation[depositors[i]] =
                (addressToDeposits[depositors[i]] * 10000) /
                totalDeposit;
        }
    }

    function distribute_rewards(uint256 _amount) private {
        for (uint256 i = 0; i < depositors.length; i++) {
            addressToDeposits[depositors[i]] +=
                (_amount * addressToPoolParticipation[depositors[i]]) /
                10000;
        }
    }

    function getDeposits(address _depositor) public view returns (uint256) {
        return addressToDeposits[_depositor];
    }

    function getPoolParticipation(address _depositor)
        public
        view
        returns (uint256)
    {
        return addressToPoolParticipation[_depositor];
    }

    function isDepositor(address _depositor) private view returns (bool) {
        bool res = false;
        for (uint256 i = 0; i < depositors.length; i++) {
            if (depositors[i] == _depositor) {
                res = true;
            }
        }
        return res;
    }
}
