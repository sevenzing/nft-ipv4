// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721/ERC721.sol";
import "./ERC721/extensions/ERC721Enumerable.sol";
import "./IPMetaInfo.sol";
import "./IPDrawer.sol";

contract InternetProtocol is IPMetaInfo, ERC721, ERC721Enumerable, Ownable {

    uint256 _totalSupply = 0;

    constructor() ERC721("Internet Protocol", "IP") {
        initializeLegendaryInfo();
    }

    function safeMint(address to, uint32 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
        _totalSupply += 1;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint32 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint32 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function totalSupply()
        public
        view
        virtual
        override(ERC721Enumerable)
        returns (uint256)
    {
        return _totalSupply;
    }


    function constructTokenURI(
        uint32 id
    ) internal view returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"image": "data:image/svg+xml;base64,',
                                Base64.encode(
                                    bytes(
                                        IPDrawer.draw(
                                            id,
                                            idToIP(id),
                                            legendaryInfo[id],
                                            determineRarity(id)
                                        )
                                    )
                                ),
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function tokenURI(
        uint256 id
    ) public view virtual override returns (string memory) {
        require(_exists(uint32(id)), "token does not exist!");
        return constructTokenURI(uint32(id));
    }
}
