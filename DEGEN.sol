// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Degen {

    string public name = "DEGEN";
    string public symbol = "DGN";
    uint8 public decimals = 0;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);




    uint public totalSupply = 0;
    uint public constant maxTotalSupply = 100000;

    mapping (address => uint) balances;

    mapping (address => mapping(address => uint)) allowances;

    
    function balanceOf(address tokenHolder) public view returns (uint256 balance) {
        return balances[tokenHolder];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] - _value >= 0, "you don't have enough funds");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }


    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }


    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowances[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(allowances[_from][msg.sender] >= _value, "you haven't been approved to spend this amount");
        require(balances[_from] - _value >= 0, "the tokenholder doesn't have enough funds");
        allowances[_from][msg.sender] -= _value;
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function burn(address, uint256 value) public  returns (bool success){
        require(balances[msg.sender] >= value, "Insufficient tokens");
        balances[msg.sender] -= value;
        totalSupply -= value;
        return true;
    }




 address public owner;

    constructor () {
        owner = msg.sender;
    }

    mapping(address=>bool) public ownsGun;
    mapping(address=>uint) public hasAmmo;
    uint public constant maxAmmo = 50;

    function mint(address reciepient, uint value) public returns (bool) {
        require(msg.sender == owner, "you are not the owner");
        require(totalSupply + value <= maxTotalSupply, "The total number of tokens have already been minted");
        balances[reciepient] += value;
        totalSupply += value;
        emit Transfer(address(0), reciepient, value);
        return true;
    }

    function buyGun() public returns (bool) {
        require(!ownsGun[msg.sender], "you already have a gun");
        require(balances[msg.sender] >= 500, "you don't have enough DEGEN to purchase a gun");
        balances[msg.sender] -= 500;
        totalSupply -= 500;
        ownsGun[msg.sender] = true;
        emit Transfer(msg.sender, address(0), 500);
        return true;
    }

    function reload() public returns (bool) {
        require(hasAmmo[msg.sender] < maxAmmo, "the magazine is full");
        require(balances[msg.sender] >= 100, "you don't have enough money to reload");
        require(ownsGun[msg.sender], "first buy a gun, then you can reload");
        balances[msg.sender] -= 100;
        totalSupply -= 100;
        hasAmmo[msg.sender] = maxAmmo;
        emit Transfer(msg.sender, address(0), 100);
        return true;
    }
}
