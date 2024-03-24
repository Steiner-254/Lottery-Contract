// Simple Lottery Contract
pragma solidity ^0.8.0;

// Contract declaration
contract SimpleLottery {
    // State variables
    address public manager;
    address[] public players;

    // Constructor to set manager
    constructor() {
        manager = msg.sender;
    }

    // Function for players to enter the lottery
    function enter() public payable {
        require(msg.value > 0.01 ether);
        players.push(msg.sender);
    }

    // Function to generate random number
    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    // Function to pick winner
    function pickWinner() public restricted {
        uint256 index = random() % players.length;
        payable(players[index]).transfer(address(this).balance);
        players = new address ;
    }

    // Modifier to restrict access to certain functions
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    // Function to get list of players
    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}

