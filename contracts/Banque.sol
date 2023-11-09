/************************************************************************************************************
 * Sujet : Banque                                                                                           *
 *                                                                                                          *
 ************************************************************************************************************/


pragma solidity >=0.5.0 <0.5.17;

import "./Token.sol";

contract Banque {

    address private owner;
    address private token;

    constructor(address tokenaddress) public {
        token = tokenaddress;
        owner = msg.sender;
    }

    //100 jetons = 1 eth
    function buy() public payable {
        require(msg.value == 1 ether, "invalid value -> 1eth = 100 token"); //verifie que la transaction soit de 1 eth
        address payable portefeuille = address(uint160(owner)); //converti l'adresse du proprietaire
        portefeuille.transfer(msg.value);

        require(
            Token(token).allowance(owner, address(this)) >= 100, //verifie la somme autorisée par le proprietaire
            "owner not allowed"
        );
        require(
            Token(token).transferFrom(owner, msg.sender, 100),
            "transfert fail"
        );
    }

    //affiche le nombre de tokens dispo
    function afficherBalance() public view returns (uint256) {
        return Token(token).allowance(owner, address(this));
    }
}
