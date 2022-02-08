// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract IFELSE {

    struct Company {
        string name;
        uint age;
        uint workers;
        string status;

    }

    mapping(address => Company) private companies;
    address public ceo;

    modifier onlyOwner() {
         require(msg.sender == ceo);
         _;// эта строчка дает компилятору понять, если условие верно, продолжи выполнение функции

    }
    constructor () public {

        ceo = msg.sender;//инициатор контракта, привязка вашего адресса при инициации ск

    }
    function addcompany (string memory name, uint age, uint workers, string memory status) public {
        require(age > 3, "Your company should be older");

        Company memory newCompany;
        newCompany.name = name;
        newCompany.age = age;
        newCompany.workers = workers;
        newCompany.status = status;

        if (workers <= 10){
            newCompany.status = "small";
        } else if (workers > 10 && workers <= 30){
            newCompany.status = "medium";

        } else {
            newCompany.status = "large";
        }
        
        insertCompany(newCompany);
    }

    function insertCompany(Company memory newCompany) private {
        address sender = msg.sender;
        companies[sender] = newCompany;

    }

    function getCompany () public view returns(string memory name, uint age, uint workers, string memory status) {
        address sender = msg.sender;
        return(companies[sender].name, companies[sender].age, companies[sender].workers, companies[sender].status);
    }

    function deleateCompany(address sender) public onlyOwner {
        
        delete companies[sender];

    }

}
