// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract PayandTransfer {
    address public owner;
    address[] public listDonaters;
    uint public timestart;
    mapping (address => uint) public donater;

    event Transaction(address _from, uint _value);

    constructor () {
        owner = msg.sender;
        timestart = block.timestamp;//вместо now сейчас используется такой синтаксис отметки начального времени 
    }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  function pay() external payable { // больше одного но меньше 5
      require(msg.value > 1 ether && msg.value < 5 ether, "Error!");
      donater[msg.sender] = donater[msg.sender] + msg.value;
      listDonaters.push(msg.sender);
      emit Transaction(msg.sender, msg.value); //для web3.js на сайте показываем сколько и кто задонатил 
  }

  function withdraw(address _to) external onlyOwner {
    require(block.timestamp > timestart + 60, "Time");
    payable(_to).transfer(address(this).balance * 90 / 100);
  }

    function getDonater() public view returns(address[] memory) {
        return listDonaters;
    }
}

