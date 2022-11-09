// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// OpenZeppelin Contracts and hardhat
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
 import "../node_modules/hardhat/console.sol";



contract SimpleNFTCreator is ERC721URIStorage {
    string _nftJsonData;
    
    struct NFT_ {
        uint _id;
        string _data;
    }

    NFT_[] public _nft_;

    mapping(uint256 => string) public idToNFT;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We need to pass the name of our  NFTs token and its symbol.
    constructor() ERC721 ('SimpleNFTCreator', 'SNFTC') {
        console.log('NFT contract deployed');
    }

    function addNFT(uint256 _itemID, string memory _nftData) public {
        _nftJsonData = Base64.encode(bytes(_nftData));
        _nft_.push(NFT_(_itemID, _nftJsonData));
    }

    function getNFTData(uint256 _itemID) public view returns(string memory) {
        return _nft_[_itemID]._data;
    }

    function getNFTCount() public view returns(uint) {
        return _nft_.length;
    }

    // A function our user will hit to get their NFT.
    function makeSimpleNFT(uint256 _itemID, string memory _nftData) public {
        addNFT(_itemID, _nftData);
        
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);
        
        // Keeps track of dynamic NFT's that are coming in
        _setTokenURI(newItemId, _nftJsonData);  
        
        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }

    // Set the NFT's metadata
    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        require(_exists(_tokenId));
        return string(
            abi.encodePacked(
                "data:application/json;base64",
                string.concat("data:application/json;base64,", getNFTData(_tokenId))
            )
        );
    }
}