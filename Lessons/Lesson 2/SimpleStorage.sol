// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage{
    uint256 favoriteNumer;

    mapping (string => uint256) public nametoFavoriteNumber;

    People[] public people;
    
    struct People{
        uint256 favoriteNumer;
        string name;
    }

    function store(uint256 _favoriteNumber) public  {
        favoriteNumer = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return  favoriteNumer;
    }

    function addPerson(uint256 _favoriteNumber,string memory _name)public {
        people.push(People(_favoriteNumber,_name));
        nametoFavoriteNumber[_name] = _favoriteNumber;
    }

}