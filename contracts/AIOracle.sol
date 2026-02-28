// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title AIOracle
 * @dev Kontrak sederhana untuk mencatat pembayaran penggunaan AI
 */
contract AIOracle {
    address public owner;
    uint256 public constant AI_QUERY_FEE = 0.01 ether;

    event QueryProcessed(address indexed user, string queryId);

    constructor() {
        owner = msg.sender;
    }

    // Fungsi untuk membayar biaya sebelum melakukan query ke AI
    function requestAIQuery(string memory _queryId) public payable {
        require(msg.value >= AI_QUERY_FEE, "Biaya tidak cukup");
        
        emit QueryProcessed(msg.sender, _queryId);
    }

    // Fungsi untuk menarik dana oleh pemilik kontrak (Nethermind)
    function withdraw() public {
        require(msg.sender == owner, "Hanya pemilik yang bisa menarik dana");
        payable(owner).transfer(address(this).balance);
    }
}
