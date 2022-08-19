//SPDX-License Identifier: MIT
pragma solidity ^0.8.4;
contract tokenA{
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint))public allowances;
    uint public totalsupply;
    string public name;
    string public symbol;
    address public owner;

    constructor(string memory _name, string memory  _symbol){
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
    }
    function balance(address account)public view returns(uint){
        return balances[account];
    }
    function allowance(address _owner, address _spender)public view returns(uint){
        return allowances[_owner][_spender];
    }
    function mint(uint amount)public {
        require(owner == msg.sender , "not the owner");
        _mint(owner, amount);
    }
    function _mint(address account, uint amount)internal virtual{
        require(account != address(0), "at 0 address");
        totalsupply += amount;
        balances[account] += amount;
    }
    function _burn(address account, uint amount)internal virtual{
        require(account != address(0), "at 0 address");
        uint curbalance = balances[account];    
        require(curbalance >= amount, "not enough money");
        totalsupply -= amount;
        balances[account] -= amount;
    }
    function transfer(address from, address to, uint amount)public {
        require(from != address(0), "at 0 address");
        require(to != address(0), "at 0 address");
        uint accbalance = balances[from];
        require(accbalance >= amount, "not enough money");
        balances[from] -= amount;
        balances[to] += amount;
    }
    function approve(address spender, uint amount)public{
        require(spender != address(0), "at 0 address");
        allowances[msg.sender][spender] = amount;
    }
    function transferFrom(address  from, address to, uint amount)public{
        require(allowances[from][msg.sender] >= amount, "not enough money");
        balances[from] -= amount;
        balances[to] += amount;
    }
}