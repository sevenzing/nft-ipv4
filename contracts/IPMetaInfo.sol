// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./IPDrawer.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract IPMetaInfo {
    using Strings for uint8;

    mapping(uint32 => string) public legendaryInfo;

    function initializeLegendaryInfo() internal {
        legendaryInfo[3324575748] = "a.root-servers.net";
        legendaryInfo[3339259593] = "b.root-servers.net";
        legendaryInfo[3223389196] = "c.root-servers.net";
        legendaryInfo[3339148045] = "d.root-servers.net";
        legendaryInfo[3234588170] = "e.root-servers.net";
        legendaryInfo[3221554673] = "f.root-servers.net";
        legendaryInfo[3228574724] = "g.root-servers.net";
        legendaryInfo[3328294453] = "h.root-servers.net";
        legendaryInfo[3223622673] = "i.root-servers.net";
        legendaryInfo[3225059358] = "j.root-servers.net";
        legendaryInfo[3238006401] = "k.root-servers.net";
        legendaryInfo[3339146026] = "l.root-servers.net";
        legendaryInfo[3389791009] = "m.root-servers.net";
        legendaryInfo[2130706433] = "localhost";

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

    function determineRarity(
        uint32 id
    ) public view returns (IPDrawer.Rarity) {
        (uint8 octet1, uint8 octet2, uint8 octet3, uint8 octet4) = idToOctets(
            id
        );
        bool isPalindrom = reverseDigits(octet4) == octet1 &&
            reverseDigits(octet3) == octet2;
        if (isLegendary(id)) {
            return IPDrawer.Rarity.Legendary;
        }

        if (
            (octet1 + 1 == octet2) &&
            (octet2 + 1 == octet3) &&
            (octet3 + 1 == octet4)
        ) {
            return IPDrawer.Rarity.Legendary;
        }

        if (
            (octet1 == octet2 + 1) &&
            (octet2 == octet3 + 1) &&
            (octet3 == octet4 + 1)
        ) {
            return IPDrawer.Rarity.Legendary;
        }

        if (
            (octet1 == octet2) &&
            (octet2 == octet3) &&
            (octet3 == octet4) 
            ) {
            return IPDrawer.Rarity.Legendary;
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
                return IPDrawer.Rarity.Legendary;
            } else {
                if (isPalindrom) return IPDrawer.Rarity.Epic;
                return IPDrawer.Rarity.Rare;
            }
        }

        if (isPalindrom) {
            return IPDrawer.Rarity.Epic;
        }

        if (
            (octet1 % 10 == 0) &&
            (octet2 % 10 == 0) &&
            (octet3 % 10 == 0) &&
            (octet4 % 10 == 0)
        ) {
            return IPDrawer.Rarity.Rare;
        }

        if (octet1 == 0 || octet1 == 255) {
            return IPDrawer.Rarity.Rare;
        }




        return IPDrawer.Rarity.Common;
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

    function isLegendary(
        uint32 id
    ) public view returns (bool) {
        return bytes(legendaryInfo[id]).length > 0;
    }
}