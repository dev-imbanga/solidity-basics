// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Coin {
    address public minter;
    mapping (address => uint) public balances;

    event Sent( address from, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }
    function mint(address receiver, uint amount)  public{
        require(msg.sender == minter)
        balances[receiver] += amount;
    }
    error InsufficientBalance(uint requested, uint available)

    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender]) revert InsufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        })
        balances[msg.sender] -= amount
        balances[receiver] += amount
        emit Sent(msg.sender, receiver, amount)
    }
}

// Breakdown of the above concepts
// The line address public minter; declares a state variable of type address. 
// The address type is a 160-bit value that does not allow any arithmetic operations.
// The keyword public automatically generates a function that allows you to access the current value of the state variable from outside of the contract.

// The next line, mapping(address => uint) public balances; also creates a public state variable, but it is a more complex datatype. 
// The mapping type maps addresses to unsigned integers.

// The constructor is a special function that is executed during the creation of the contract and cannot be called afterwards. 
// In this case, it permanently stores the address of the person creating the contract. 
// The msg variable (together with tx and block) is a special global variable that contains properties which allow access to the blockchain.
//  msg.sender is always the address where the current (external) function call came from.

// The line event Sent(address from, address to, uint amount); declares an “event”, 
// which is emitted in the last line of the function send. 
// Ethereum clients such as web applications can listen for these events emitted on the blockchain without much cost. 
// As soon as it is emitted, the listener receives the arguments from, to and amount, which makes it possible to track transactions.

// The mint function sends an amount of newly created coins to another address. 
// The require function call defines conditions that reverts all changes if not met.
//  In this example, require(msg.sender == minter); ensures that only the creator of the contract can call mint. 
//  In general, the creator can mint as many tokens as they like, but at some point, this will lead to a phenomenon called “overflow”.

// Errors allow you to provide more information to the caller about why a condition or operation failed.
//  Errors are used together with the revert statement. 
//  The revert statement unconditionally aborts and reverts all changes.
//  it is similar to the require function, but it also allows you to provide the name of an error and additional data,
//   which will be supplied to the caller (and eventually to the front-end application or block explorer) so that a failure can more easily be debugged or reacted upon.


// The send function can be used by anyone (who already has some of these coins) to send coins to anyone else. 
// If the sender does not have enough coins to send, the if condition evaluates to true. 
// As a result, the revert will cause the operation to fail while providing the sender with error details using the InsufficientBalance error.