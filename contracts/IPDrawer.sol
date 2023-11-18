// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "solady/src/utils/LibString.sol";

library IPDrawer {
    enum Rarity {
        Common,
        Rare,
        Epic,
        Legendary
    }

    struct RarityDrawInfo {
        string RARE_TYPE;
        string STROKE_COLOR;
        string BACKGROUND_COLOR_START;
        string BACKGROUND_COLOR_END;
    }

    struct IdDrawInfo {
        string UNIQUE_COLOR_START;
        string UNIQUE_COLOR_END;
    }

    function rarityToInfo (
        Rarity rarity
    ) internal pure returns (RarityDrawInfo memory info) {
        if (Rarity.Common == rarity) 
            return RarityDrawInfo('COMMON','F3F3E0','495162','84877B');
        if (Rarity.Rare == rarity) 
            return RarityDrawInfo('RARE','','','');
        if (Rarity.Epic == rarity) 
            return RarityDrawInfo('EPIC','','','');
        if (Rarity.Legendary == rarity) 
            return RarityDrawInfo('LEGENDARY','','','');
    }

    function idToInfo(
        uint32 id
    ) internal pure returns (IdDrawInfo memory info) {
        string memory color1 = uint32ToHexColor(id);
        string memory color2 = uint32ToHexColor(0xFFFFFFFF - id);
        return IdDrawInfo(color1, color2);
    }


    function uint32ToHexColor(uint32 id) public pure returns (string memory) {
        bytes memory hexColor = abi.encodePacked(id);
        return iToHex(hexColor);
    }

    function iToHex(bytes memory buffer) public pure returns (string memory converted)  {
        bytes memory converted = new bytes(buffer.length * 2);
        bytes memory _base = "0123456789abcdef";
        for (uint256 i = 0; i < buffer.length; i++) {
            converted[i * 2] = _base[uint8(buffer[i]) / _base.length];
            converted[i * 2 + 1] = _base[uint8(buffer[i]) % _base.length];
        }
    }

    function draw(
        uint32 id,
        string memory ip,
        string memory meta_text,
        Rarity rarity
    )
        public
        pure
        returns (
            // Rarity rarity
            string memory
        )
    {
        RarityDrawInfo memory r_info = rarityToInfo(rarity);
        IdDrawInfo memory id_info = idToInfo(id);
        string
            memory svg = '<svg width="284" height="377" viewBox="0 0 284 377" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><style type="text/css">@import url("https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@100");@keyframes movePacket{0%{transform:translate(60px,32px)}25%{transform:translate(120px,32px)}50%{transform:translate(140px,32px)}75%{transform:translate(150px,32px)}100%{transform:translate(200px,32px)}}#packet{animation:movePacket 2s linear infinite;transform-origin:center center;}text{font-family:"Roboto Mono",monospace;font-weight:bold;fill:#fff;}.ip-address{font-size:25px;}.meta{font-size:19px;}.meta_t{font-size:10px;}.rare{font-size:8px;}</style><g filter="url(#filter0_d_0_1)"><rect x="4" width="277" height="369" rx="10" fill="url(#paint0_linear_0_1)" fill-opacity="0.63" style="mix-blend-mode:hard-light" shape-rendering="crispEdges"/></g><g filter="url(#filter1_d_0_1)"><rect x="13.5" y="9.5" width="258" height="350" rx="7.5" stroke="#STROKE_COLOR" stroke-opacity="0.62" shape-rendering="crispEdges"/></g><line y1="-0.5" x2="138" y2="-0.5" transform="matrix(0.999947 0.0103178 -0.00610438 0.999981 30 245)" stroke="#FDFDFD"/><text x="140" y="150" class="ip-address" text-anchor="middle" dominant-baseline="middle">IP_VALUE</text><text x="30" y="240" class="meta_t">META_TEXT</text><text x="30" y="265" class="meta">IPv4 ADDRESS</text><text x="35" y="349" class="rare">RARE_TYPE</text><svg id="computer" fill="#000" x="20" y="25" width="50px" height="50px" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><title/><path fill="#f0f0f0" d="M80,27.13H61a2,2,0,0,0-2,2v2.94H20a2,2,0,0,0-2,2V64.65a2,2,0,0,0,2,2h9.41a8.13,8.13,0,0,0-1.18,4.23,2,2,0,0,0,2,2H50.79a2,2,0,0,0,2-2,8.13,8.13,0,0,0-1.18-4.23H59v4.23a2,2,0,0,0,2,2H80a2,2,0,0,0,2-2V29.13A2,2,0,0,0,80,27.13ZM32.73,68.88a4.23,4.23,0,0,1,3.72-2.23h8.12a4.23,4.23,0,0,1,3.72,2.23ZM59,62.65H22V36.07H59Zm19,6.23H63V31.13H78Z"/></svg><use xlink:href="#computer" x="195" y="0" /><g x="60" y="32" id="packet" data-name="Layer 2"><path fill="#f0f0f0" d="M21.75 8.25H2.25C2.05109 8.25 1.86032 8.32902 1.71967 8.46967C1.57902 8.61032 1.5 8.80109 1.5 9V21.75C1.5 21.9489 1.57902 22.1397 1.71967 22.2803C1.86032 22.421 2.05109 22.5 2.25 22.5H21.75C21.9489 22.5 22.1397 22.421 22.2803 22.2803C22.421 22.1397 22.5 21.9489 22.5 21.75V9C22.5 8.80109 22.421 8.61032 22.2803 8.46967C22.1397 8.32902 21.9489 8.25 21.75 8.25ZM19.6575 9.75L12 15.1725L4.3425 9.75H19.6575ZM3 21V10.635L11.565 16.7025C11.692 16.7929 11.8441 16.8415 12 16.8415C12.1559 16.8415 12.308 16.7929 12.435 16.7025L21 10.635V21H3Z"/></g><g filter="url(#filter2_d_0_1)"><path d="M184 222C184 217.029 188.029 213 193 213H250C254.971 213 259 217.029 259 222V280C259 284.971 254.971 289 250 289H193C188.029 289 184 284.971 184 280V222Z" fill="url(#paint1_linear_0_1)"/></g><g clip-path="url(#clip0_0_1)"><path d="M221.5 228C208.542 228 198 238.318 198 251C198 263.682 208.542 274 221.5 274C234.458 274 245 263.682 245 251C245 238.318 234.458 228 221.5 228ZM215.833 231.093C214.835 232.076 213.922 233.369 213.134 235.042C212.532 236.319 212.012 237.79 211.577 239.205H204.17C206.939 235.313 211.044 232.402 215.833 231.093ZM202.721 241.564H210.98C210.419 244.159 210.092 246.99 210.025 249.82H200.442C200.607 246.872 201.41 244.159 202.721 241.564ZM200.448 252.179H210.028C210.101 255.128 210.433 257.959 211.001 260.436H202.772C201.446 257.959 200.627 255.246 200.448 252.179ZM204.236 262.795H211.604C212.033 264.328 212.545 265.649 213.134 266.9C213.906 268.539 214.805 269.833 215.79 270.837C211.058 269.533 206.996 266.687 204.236 262.795ZM220.295 271.449C218.005 270.674 215.613 267.631 214.102 262.795H220.295V271.449ZM220.295 260.436H213.453C212.881 258.077 212.515 255.246 212.438 252.18H220.295L220.295 260.436ZM220.295 249.821H212.436C212.507 246.99 212.853 244.159 213.446 241.564H220.295V249.821ZM220.295 239.205H214.088C214.446 238.144 214.839 237.026 215.303 236.041C216.712 233.05 218.487 231.137 220.295 230.549V239.205ZM242.558 249.821H232.975C232.908 246.99 232.581 244.159 232.02 241.564H240.279C241.59 244.159 242.393 246.872 242.558 249.821ZM238.83 239.205H231.423C230.988 237.79 230.468 236.33 229.866 235.053C229.083 233.393 228.205 232.084 227.249 231.103C232.003 232.423 236.077 235.431 238.83 239.205ZM222.705 230.574C224.513 231.192 226.268 233.094 227.657 236.041C228.121 237.026 228.554 238.144 228.912 239.205H222.705L222.705 230.574ZM222.705 241.564H229.554C230.147 244.159 230.493 246.99 230.564 249.82H222.705V241.564ZM222.705 252.179H230.562C230.484 255.246 230.119 258.077 229.547 260.436H222.705V252.179ZM222.705 271.423V262.795H228.898C227.404 267.513 225.115 270.606 222.705 271.423ZM227.337 270.813C228.256 269.814 229.103 268.507 229.866 266.888C230.455 265.638 230.966 264.328 231.396 262.795H238.764C236.029 266.687 232.015 269.492 227.337 270.813ZM240.228 260.436H232C232.567 257.959 232.899 255.128 232.973 252.18H242.552C242.373 255.246 241.554 257.959 240.228 260.436Z" fill="white"/></g><g filter="url(#filter3_d_0_1)"><circle cx="27" cy="21" r="3" fill="white"/></g><g filter="url(#filter4_d_0_1)"><ellipse cx="261.5" cy="21" rx="2.5" ry="3" fill="white"/></g><g filter="url(#filter5_d_0_1)"><ellipse cx="261.5" cy="346" rx="2.5" ry="3" fill="white"/></g><g filter="url(#filter6_d_0_1)"><circle cx="27" cy="346" r="3" fill="white"/></g><defs><filter id="filter0_d_0_1" x="0" y="0" width="285" height="377" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/><feOffset dy="4"/><feGaussianBlur stdDeviation="2"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/><feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_0_1"/><feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1" result="shape"/></filter><filter id="filter1_d_0_1" x="9" y="9" width="267" height="359" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/><feOffset dy="4"/><feGaussianBlur stdDeviation="2"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/><feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_0_1"/><feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1" result="shape"/></filter><filter id="filter2_d_0_1" x="180" y="213" width="83" height="84" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/><feOffset dy="4"/><feGaussianBlur stdDeviation="2"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/><feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_0_1"/><feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1" result="shape"/></filter><filter id="filter3_d_0_1" x="20" y="14" width="14" height="14" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/><feOffset/><feGaussianBlur stdDeviation="2"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/><feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_0_1"/><feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1" result="shape"/></filter><filter id="filter4_d_0_1" x="255" y="14" width="13" height="14" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/><feOffset/><feGaussianBlur stdDeviation="2"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/><feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_0_1"/><feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1" result="shape"/></filter><filter id="filter5_d_0_1" x="255" y="339" width="13" height="14" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/><feOffset/><feGaussianBlur stdDeviation="2"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/><feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_0_1"/><feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1" result="shape"/></filter><filter id="filter6_d_0_1" x="20" y="339" width="14" height="14" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"><feFlood flood-opacity="0" result="BackgroundImageFix"/><feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/><feOffset/><feGaussianBlur stdDeviation="2"/><feComposite in2="hardAlpha" operator="out"/><feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/><feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_0_1"/><feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1" result="shape"/></filter><linearGradient id="paint0_linear_0_1" x1="20.62" y1="16.605" x2="289.917" y2="383.992" gradientUnits="userSpaceOnUse"><stop offset="0.5625" stop-color="#BACKGROUND_COLOR_START"/><stop offset="1" stop-color="#BACKGROUND_COLOR_END" stop-opacity="0"/></linearGradient><linearGradient id="paint1_linear_0_1" x1="221.5" y1="213" x2="221.5" y2="289" gradientUnits="userSpaceOnUse"><stop stop-color="#UNIQUE_COLOR_START"/><stop offset="1" stop-color="#UNIQUE_COLOR_END"/></linearGradient><clipPath id="clip0_0_1"><rect width="47" height="46" fill="white" transform="translate(198 228)"/></clipPath><clipPath id="clip0_0_2"><rect width="470" height="460" fill="white" transform="translate(0 0)"/></clipPath></defs></svg>';
        svg = LibString.replace(svg, "STROKE_COLOR", r_info.STROKE_COLOR);
        svg = LibString.replace(svg, "IP_VALUE", ip);
        svg = LibString.replace(svg, "RARE_TYPE", r_info.RARE_TYPE);
        svg = LibString.replace(svg, "BACKGROUND_COLOR_START", r_info.BACKGROUND_COLOR_START);
        svg = LibString.replace(svg, "BACKGROUND_COLOR_END", r_info.BACKGROUND_COLOR_END);
        svg = LibString.replace(svg, "UNIQUE_COLOR_START", id_info.UNIQUE_COLOR_START);
        svg = LibString.replace(svg, "UNIQUE_COLOR_END", id_info.UNIQUE_COLOR_END);
        svg = LibString.replace(svg, "META_TEXT", meta_text);
        return svg;
    }
}
