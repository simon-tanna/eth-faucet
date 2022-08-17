// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// This countract will have a changable owner

contract Faucet {
    // set the state variables that will track owner and the amount of ETH to dispense from faucet
    address public owner;
    uint public maxAllowedEth = 100000000000000000;

    // mapping here will keep track of requested tokens
    // the requestor can only request ETH 1 time per day
    // the address and blocktime + 1 day is saved in lockTime
    mapping(address => uint) public lockTime;

    // constructor will set the payable owner
    // msg.sender is the owner address
    constructor() payable {
        owner = msg.sender;
    }

    // this modifier ensures that only the owner can call the function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform that action");
        _;
    }

    // this modifier checks that the requestor balance is not greater that the max amount of eth that can be dispensed.
    modifier maxRequestorBalance() {
        require(msg.sender.balance <= maxAllowedEth, "You have too much eth");
        _;
    }

    // this function changes the owner of the contract.
    // only the owner of this contract can call the function
    function setOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    // this function can set the allowable amount of ETH to be claimed.
    // onlyOwner is invoked in this function as well
    function setMaxEthAmount(uint newMaxEthAmount) public onlyOwner {
        maxAllowedEth = newMaxEthAmount;
    }

    // this is a donation function that allows funds to be donated to the faucet contract
    function donateToFaucet() public payable {}

    // this function will send tokens from the faucet contract a requested address
    function tokenRequest(address payable _requestor)
        public
        payable
        maxRequestorBalance
    {
        // error handling checks to verify that the function can execute
        require(
            block.timestamp > lockTime[msg.sender],
            "The amount of time that you can wait before requesting another token has not refreshed, Try again later"
        );
        require(
            address(this).balance > maxAllowedEth,
            "This faucet does not have enough funds... Please donate"
        );

        // if the balance of this contract is greater than the requested amount of funds, send funds to the requestor
        _requestor.transfer(maxAllowedEth);

        // update the locktime
        lockTime[msg.sender] = block.timestamp + 1 days;
    }
}
