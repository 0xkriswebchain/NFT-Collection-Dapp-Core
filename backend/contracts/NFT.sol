// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// 0xA5a120b2961512338A2fFb5F5F4f0bA49A2DA4e8

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract CoreNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Strings for uint256;

    uint256 private nextTokenId;
    string private baseURIExtended;

    constructor(string memory baseURI_) ERC721("CoreNFT", "CORE") Ownable(msg.sender) {
        baseURIExtended = baseURI_;
        nextTokenId = 0;
    }

    function setBaseURI(string memory baseURI_) external onlyOwner {
        baseURIExtended = baseURI_;
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, string(abi.encodePacked(Strings.toString(tokenId), ".json")));
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURIExtended;
    }

    function getCurrentTokenId() public view returns (uint256) {
        return nextTokenId;
    }
    // The following functions have to be overridden as required by Solidity.

    function _update(address _to, uint256 _tokenId, address _auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(_to, _tokenId, _auth);
    }

    function _increaseBalance(address _account, uint128 _value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(_account, _value);
    }

    function tokenURI(uint256 _tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, _tokenId.toString(), ".json")) : "";
    }

    function supportsInterface(bytes4 _interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(_interfaceId);
    }
}
