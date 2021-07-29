// SPDX-License-Identifier: MIT

/// @title: Satellites: Sounds Beyond Sight
/// @author: EUCLiD

pragma solidity ^0.8.0;

import "./core/IERC721CreatorCore.sol";
import "./extensions/ICreatorExtensionBase.sol";
import "./extensions/IERC721CreatorExtensionBurnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";


contract SSBSTest is Ownable, ERC165 {
    address private _creator;
    uint256 public satelliteCount = 0;
    uint256 public satelliteLimit = 3;
    event SatelliteLaunched(address indexed _receiver, uint256 indexed _tokenID);
    event LaunchFailure(address indexed _caller);
    event SatelliteBurned(address indexed _receiver, uint256 indexed _tokenID);

    constructor(address creator) {
        _creator = creator;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    return interfaceId == type(ICreatorExtensionBase).interfaceId || type(ICreatorExtensionBurnable).interfaceId || super.supportsInterface(interfaceId);
    }

    function launch(address receiver, string calldata uri) external onlyOwner {
        if (satelliteCount < satelliteLimit) {
            satelliteCount++;
            IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).mintExtension(receiver,uri);
            emit SatelliteLaunched(receiver, satelliteCount);
        } else {
            emit LaunchFailure(receiver);
        }
    }

    function burn(uint256 tokenId) external {
        IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).burn(tokenId);
        satelliteCount--;
        emit SatelliteBurned(msg.sender, tokenId);
    }

    function setBaseTokenURI(string calldata uri, bool identical) external onlyOwner {
        IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).setBaseTokenURIExtension(uri, identical);
    }

    function setTokenURI(uint256[] calldata tokenIds, string[] calldata uris) external onlyOwner {
        IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).setTokenURIExtension(tokenIds, uris);
    }    

    function setTokenURIPrefix(string calldata prefix) external onlyOwner {
        IERC721CreatorCore(0x140c5AEe63e81a7627Ae3F054D6A1B25FbBA0C8d).setTokenURIPrefixExtension(prefix);
    }
}