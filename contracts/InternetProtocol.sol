// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721/ERC721.sol";
import "./ERC721/extensions/ERC721Enumerable.sol";
import "./IPDrawer.sol";

contract InternetProtocol is ERC721, ERC721Enumerable, Ownable {
    using Strings for uint8;
    enum Rarity {
        Common,
        Rare,
        Epic,
        Legendary
    }
    uint32[] legendaryIds = [
        3324575748, // a.root-servers.net	198.41.0.4
        3339259593, // b.root-servers.net	199.9.14.201
        3223389196, // c.root-servers.net	192.33.4.12
        3339148045, // d.root-servers.net	199.7.91.13
        3234588170, // e.root-servers.net	192.203.230.10
        3221554673, // f.root-servers.net	192.5.5.241
        3228574724, // g.root-servers.net	192.112.36.4
        3328294453, // h.root-servers.net	198.97.190.53
        3223622673, // i.root-servers.net	192.36.148.17
        3225059358, // j.root-servers.net	192.58.128.30
        3238006401, // k.root-servers.net	193.0.14.129
        3339146026, // l.root-servers.net	199.7.83.42
        3389791009, // m.root-servers.net	202.12.27.33
        2130706433 // 127.0.0.1
    ];

    uint256 _totalSupply = 4294967296;

    constructor() ERC721("Internet Protocol", "IP") {}

    function safeMint(address to, uint32 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function idToOctets(
        uint32 id
    ) public pure returns (uint8, uint8, uint8, uint8) {
        uint8 octet1 = uint8(id >> 24) & 255;
        uint8 octet2 = uint8(id >> 16) & 255;
        uint8 octet3 = uint8(id >> 8) & 255;
        uint8 octet4 = uint8(id) & 255;

        return (octet1, octet2, octet3, octet4);
    }

    function determineRarity(uint32 id) internal view returns (Rarity) {
        (uint8 octet1, uint8 octet2, uint8 octet3, uint8 octet4) = idToOctets(
            id
        );
        bool isPalindrom = reverseDigits(octet4) == octet1 &&
            reverseDigits(octet3) == octet2;
        if (checkMembership(id, legendaryIds)) {
            return Rarity.Legendary;
        }

        if (
            (octet1 + 1 == octet2) &&
            (octet2 + 1 == octet3) &&
            (octet3 + 1 == octet4)
        ) {
            return Rarity.Legendary;
        }

        if (
            areAllSameDigits(octet1) &&
            areAllSameDigits(octet2) &&
            areAllSameDigits(octet3) &&
            areAllSameDigits(octet4)
        ) {
            uint8 d1 = octet1 % 10;
            uint8 d2 = octet2 % 10;
            uint8 d3 = octet3 % 10;
            uint8 d4 = octet4 % 10;
            if (d1 == d2 && d2 == d3 && d3 == d4) {
                return Rarity.Legendary;
            } else {
                if (isPalindrom) return Rarity.Epic;
                return Rarity.Rare;
            }
        }

        if (
            (octet1 % 10 == 0) &&
            (octet2 % 10 == 0) &&
            (octet3 % 10 == 0) &&
            (octet4 % 10 == 0)
        ) {
            return Rarity.Rare;
        }

        if (isPalindrom) {
            return Rarity.Epic;
        }

        return Rarity.Common;
    }

    function reverseDigits(uint8 number) public pure returns (uint8) {
        uint8 reversed = 0;

        while (number > 0) {
            uint8 digit = number % 10;
            reversed = (reversed * 10) + digit;
            number /= 10;
        }

        return reversed;
    }

    function areAllSameDigits(uint32 octet) internal pure returns (bool) {
        uint8 d1 = uint8(octet % 10);
        uint8 d2 = uint8((octet / 10) % 10);
        uint8 d3 = uint8((octet / 100) % 10);
        return d1 == d2 && d2 == d3;
    }

    function checkMembership(
        uint32 id,
        uint32[] storage ids
    ) internal view returns (bool) {
        for (uint8 i = 0; i < ids.length; i++) {
            if (ids[i] == id) return true;
        }
        return false;
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

    function idToIP(uint32 id) public pure returns (string memory) {
        (uint8 octet1, uint8 octet2, uint8 octet3, uint8 octet4) = idToOctets(
            id
        );

        return
            string(
                abi.encodePacked(
                    octet1.toString(),
                    ".",
                    octet2.toString(),
                    ".",
                    octet3.toString(),
                    ".",
                    octet4.toString()
                )
            );
    }

    function constructTokenURI(
        uint32 id
    ) internal pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"image": "data:image/svg+xml;base64,',
                                Base64.encode(bytes(IPDrawer.draw(idToIP(id)))),
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
