// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// OpenZeppelin Contracts and hardhat
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "hardhat/console.sol";

contract JSNFT is ERC721URIStorage {
    uint256 _user_nft_number;
    string _nftJsonData;
    
    event EmitUserCreatedNFT(string _nftData);

    struct UserNFTData {
        string _nftData;
    }

    UserNFTData[] userNft;

    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We need to pass the name of our  NFTs token and its symbol.
    constructor() ERC721 ('jsNFT', 'JSNFT'){
        console.log('NFT contract deployed');
    }

    // A function our user will hit to get their NFT.
    function makeJSNFT() public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }

    function setNFTData(uint256 _itemID, string memory _nftData) public {
        _user_nft_number = _itemID;
        console.log(_nftData);
        _nftJsonData = Base64.encode(bytes(_nftData));
        userNft.push(UserNFTData(_nftData));
        emit EmitUserCreatedNFT(_nftData);
    }

    function getNFTData() public view returns (UserNFTData[] memory){
        return userNft;
    }

    // Set the NFT's metadata
    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        require(_exists(_tokenId));
        // getNFTData();
        // console.log(string.concat("data:application/json;base64", _nftJsonData));
        // console.log("An NFT SVG w/ ID %s has been minted to %s", _tokenId, msg.sender);
        return string(
            abi.encodePacked(
                "data:application/json;base64",
                string.concat("data:application/json;base64,", _nftJsonData)
            )
        );
    }
}