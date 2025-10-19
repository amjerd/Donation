// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Donation{

    //immutable and uint256 are used to save gas
    //immutable while variable never change

    address immutable owner;// saves storage slot
    uint256 public totalDonation;//total donation accross all users

    //track each donor amount
    mapping (address => uint256) public Donations;

    event Donated(address indexed donor,uint256 amount);
    event withdrawal(address indexed owner,uint256 amount);

    constructor(){
        owner = msg.sender;
    }

    function Donate()public payable {
        //this line say if u send us 0 eth then we will say something lol
        require(msg.value > 0,"must be greater than zero");

        //and this say "this user donate some value please save it"
        Donations[msg.sender] += msg.value;

        //since this user donate "then add his value to totalDonation"
        totalDonation += msg.value;

        //blockchain save and record this event and amount sent by this user
        emit Donated(msg.sender, msg.value);
    }

    //if this user sent ETH directly plain without data you run automatically!
    receive() external payable { 
         Donations[msg.sender] += msg.value;
         totalDonation += msg.value;
        emit Donated(msg.sender, msg.value);
    }

    //for you when they sent with data(msg.data) or call wrong function run!
    fallback() external payable { 
         Donations[msg.sender] += msg.value;
        totalDonation += msg.value;
        emit Donated(msg.sender, msg.value);
    }

    function withdraw() public {
    // Only the boss (owner) can touch the money
    require(msg.sender == owner, "unauthorized");

    //you "Count how much ETH we have stored in thecontract"
    uint256 amount = address(this).balance;

    // and you "If the balance is empty,reject the transaction!"
    require(amount > 0, "no amount to withdraw");

    //Try sending all the ETH to the boss
    (bool success, ) = payable(owner).call{value: amount}("");

    //If the transaction fails,roll everything back
    require(success, "failed to send");

    // Announce to the world that the boss just grabbed the ETH!
    emit withdrawal(owner, amount);
}


    function totalContractBalance() private view returns (uint256) {
    //check inside the vault to see how much ETH is chilling here!
    // No touching though — just looking
    return address(this).balance;
}

}
