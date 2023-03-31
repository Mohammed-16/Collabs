// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ImageNFT is ERC721 {
    uint256 private _tokenIdTracker;
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("ImageNFT", "INFT") {}

    function mint(address to, string memory tokenURI) public returns (uint256) {
        uint256 newTokenId = _tokenIdTracker;
        _safeMint(to, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        _tokenIdTracker++;
        return newTokenId;
    }

    function _setTokenURI(uint256 tokenId, string memory uri) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = uri;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }
}
contract ImageNFTTransfer {
    ImageNFT private _imageNFT;

    constructor(address imageNFTContractAddress) {
        _imageNFT = ImageNFT(imageNFTContractAddress);
    }

    function transferNFT(address to, uint256 tokenId) public {
        require(_imageNFT.ownerOf(tokenId) == msg.sender, "ImageNFTTransfer: You do not own this NFT.");
        _imageNFT.safeTransferFrom(msg.sender, to, tokenId);
    }
}