//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
interface ItokenA {
    //function approve(address spender, uint amount)external returns(uint);
    function transfer(address from, address to, uint amount)external;
    function transferFrom(address from, address to, uint amount)external;  
    function mint(address account, uint amount)external;
}
interface ItokenS{
    function transferFrom(address from, address to, uint amount)external;
}
contract sbank {
    mapping (address => uint)public ledger; // stores the amount of asset getting deposit in our account
    mapping (address => uint)public time;    // stores the time of depositing the money
    address _tokenA;
    constructor(address _adr){
        _tokenA = _adr;
    }
    //  shashi token for 1 unit of time st = 2
    uint public st = 2; //shashi tokens
    function Deposit(uint _amount)public{
        ItokenA(_tokenA).transferFrom(msg.sender, address(this), _amount);
        ledger[msg.sender] += _amount;
        time[msg.sender] = block.timestamp;

    }

    function withdraw(uint _amount)public {
        uint wtime = block.timestamp;
        uint tst = (wtime - time[msg.sender]) * st;//total shashi tokens
        // check if user has depoited more that > 
        require(ledger[msg.sender] >= _amount , "not enough aman token deposited");
        ItokenA(_tokenA).transfer(address(this), msg.sender, _amount);
        ledger[msg.sender] -= _amount;
        //shashi token code
        ItokenA(_tokenA).mint(msg.sender,tst);
    }
}