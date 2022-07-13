// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WhitelistSale is ERC721, Ownable {
    bytes32 public merkleRoot;
    uint256 public nextTokenId = 1;
    uint256 public maxSupply = 10;
    mapping(address => bool) public claimed;

    constructor(bytes32 _merkleRoot) ERC721("TestMerkleNFT", "TMNFT") {
        merkleRoot = _merkleRoot;
    }

    function updateMerkleRoot(bytes32 _newMerkleRoot) external onlyOwner {
        merkleRoot = _newMerkleRoot;
    }

    function toBytes32(address addr) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(addr)));
    }

    function mint(bytes32[] calldata merkleProof) public payable {
        require(claimed[msg.sender] == false, "You have already claimed");
        require(nextTokenId <= maxSupply, "We have minted out!");
        claimed[msg.sender] = true;
        require(
            MerkleProof.verify(
                merkleProof,
                merkleRoot,
                keccak256(abi.encodePacked(msg.sender))
            ) == true,
            "invalid merkle proof"
        );
        nextTokenId++;
        _mint(msg.sender, nextTokenId);
    }
}
