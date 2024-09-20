// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

/**
 * @title CoreNFT
 * @dev A comprehensive ERC721 implementation with enumerable and URI storage extensions.
 */
contract CoreNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Strings for uint256;

    uint256 private nextTokenId;
    string private baseURIExtended;

    /**
     * @dev Initializes the contract by setting a `baseURI` and the token name and symbol.
     * @param baseURI_ The base URI for the token metadata.
     */
    constructor(string memory baseURI_) ERC721("CoreNFT", "CORE") Ownable(msg.sender) {
        baseURIExtended = baseURI_;
        nextTokenId = 0;
    }

    /**
     * @dev Sets the base URI for the token metadata.
     * @param baseURI_ The new base URI.
     */
    function setBaseURI(string memory baseURI_) external onlyOwner {
        baseURIExtended = baseURI_;
    }

    /**
     * @dev Safely mints a new token and assigns it to `to`.
     * @param to The address to which the token will be minted.
     */
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, string(abi.encodePacked(Strings.toString(tokenId), ".json")));
    }

    /**
     * @dev Returns the base URI for the token metadata.
     * @return The base URI string.
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURIExtended;
    }

    /**
     * @dev Returns the current token ID.
     * @return The current token ID.
     */
    function getCurrentTokenId() public view returns (uint256) {
        return nextTokenId;
    }

    // The following functions have to be overridden as required by Solidity.

    /**
     * @dev Updates the token ownership.
     * @param _to The address to which the token is transferred.
     * @param _tokenId The token ID.
     * @param _auth The authorized address.
     * @return The previous owner address.
     */
    function _update(address _to, uint256 _tokenId, address _auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(_to, _tokenId, _auth);
    }

    /**
     * @dev Increases the balance of the account.
     * @param _account The account address.
     * @param _value The value to increase.
     */
    function _increaseBalance(address _account, uint128 _value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(_account, _value);
    }

    /**
     * @dev Returns the token URI for a given token ID.
     * @param _tokenId The token ID.
     * @return The token URI string.
     */
    function tokenURI(uint256 _tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, _tokenId.toString(), ".json")) : "";
    }

    /**
     * @dev Checks if the contract supports a given interface.
     * @param _interfaceId The interface ID.
     * @return True if the interface is supported, false otherwise.
     */
    function supportsInterface(bytes4 _interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(_interfaceId);
    }
}
