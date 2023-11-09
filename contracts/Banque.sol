pragma solidity >=0.5.0 <0.5.17;

import "./Token.sol";


contract Banque {
    address private owner;
    address private token;

    //set contrat : token et owner
    constructor(address tokenaddress) public {
        token = tokenaddress;
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
    }

    //100 tokens = 1 eth
    function buy() public payable {
        require(msg.value == 1 ether, "invalid value -> 1eth = 100 token"); // check the amount paid for the purchase = 1eth
        address payable portefeuille = address(uint160(owner)); // converted the owner's address to a payable address
        portefeuille.transfer(msg.value); // transfer the amount received to the owner account

        require(
            Token(token).allowance(owner, address(this)) >= 100, //verifie la somme autorisée par le proprietaire
            "owner not allowed"
        );
        require(
            Token(token).transferFrom(owner, msg.sender, 100),
            "transfert fail"
        );
    }

    //affiche le nobre de tokens dispo
    function afficherBalance() public view returns (uint256) {
        return Token(token).allowance(owner, address(this)); // amount that the owner has authorized to be used by the contract
    }
}
