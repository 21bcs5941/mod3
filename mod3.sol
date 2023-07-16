//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

contract Digentoken {
    string public tokenName;
    string public abbrv;
    uint public totalSupply = 0;
    address public owner;

    mapping(address => uint) public Balances;

    constructor(string memory _mytoken, string memory _mysymb, uint _supply) {
        tokenName = _mytoken;
        abbrv = _mysymb;
        totalSupply = _supply;
        owner = msg.sender;
    }



    modifier Owner() {
        require(msg.sender == owner, "for accessing it you need to be the owner");
        _;
    }

    error InsuficientBalance(uint256 YourBalance, uint256 YourAmount);

    function burn(address _address, uint256 _value) public {
        if (Balances[_address] < _value) {
            revert InsuficientBalance({
                YourBalance: Balances[_address],
                YourAmount: _value
            });
        }
        totalSupply -= _value;
        Balances[_address] -= _value;
    }

    function transfer(address sender, address receiver, uint256 amount) public {
        if (Balances[sender] < amount) {
            revert InsuficientBalance({
                YourBalance: Balances[sender],
                YourAmount: amount
            }); 
        }
        Balances[sender] -= amount;
        Balances[receiver] += amount;
    }

    function mint(address _address, uint value) public Owner {
        totalSupply += value;
        Balances[_address] += value;
    }
}

//reference
//sender id :0xbe983FF21bED77f617B5782617E6885C32E5388e
// receiver id:0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
