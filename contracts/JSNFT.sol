// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// OpenZeppelin Contracts and hardhat
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract JSNFT is ERC721URIStorage {
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We need to pass the name of our NFTs token and its symbol.
    constructor() ERC721 ('jsNFT', 'JSNFT'){
        console.log('NFT contract deployed');
    }

    // A function our user will hit to get their NFT.
    function makeJSNFT() public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.
        _setTokenURI(newItemId, 'https://jsonkeeper.com/b/BRMZ');
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}