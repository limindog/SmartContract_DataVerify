// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract CompanyDataVerify{
    address Owner;
    mapping (address => bool) public SafeList;
    struct InstantInformation{
        string time;
        string temperature;
        string Weather;
        int Humidity;
        int POP;  
        address Contributor;
        bool isValue;
            }

    constructor (){
        Owner=msg.sender;
        SafeList[Owner]=true; 
    }
    modifier onlyOwner {
        require(msg.sender == Owner);
        _; 
    }
    mapping(string => InstantInformation) public ForecastData;

   
    function getOwner() public view returns(address){
        return Owner;
    }
    function addSafeList(address Address) public onlyOwner{
            SafeList[Address]=true;
    }
    function revokeSafeList(address Address) public onlyOwner{
            SafeList[Address]=false;
    }
    function changeOwner(address Address) public onlyOwner{
        require (SafeList[Address]==true, "You are changing Owner right to unsafe address, please make sure your action!");
        Owner=Address;
    }
    function addData(string memory Location,string memory ti,string memory T,string memory W, int H, int P, address Address) public returns(string memory){
            require(SafeList[msg.sender]==true,"You have no right to add new weather data, please contact the owner!");
            InstantInformation storage Data=ForecastData[Location];
            Data.isValue=true;
            Data.time=ti;
            Data.temperature=T;
            Data.Weather=W;
            Data.Humidity=H;
            Data.POP=P;
            Data.Contributor=Address;
            return string(abi.encodePacked("Add ",Location," successfully"));
    }
    function delData(string memory Location) public returns(string memory){
            require(SafeList[msg.sender]==true,"You have no right to add new weather data, please contact the owner!");
            require(ForecastData[Location].isValue==true,"Please make sure you typing right location name");
            delete ForecastData[Location];
            return string(abi.encodePacked("Delete ",Location," successfully"));
    }
    function updateData(string memory Location,string memory ti,string memory T,string memory W, int H, int P, address Address) public returns(string memory){
            require(ForecastData[Location].isValue==true,"Please make sure you typing right location name");
            InstantInformation storage Data=ForecastData[Location];
            Data.isValue=true;
            Data.temperature=T;
            Data.Weather=W;
            Data.time=ti;
            Data.Humidity=H;
            Data.POP=P;
            Data.Contributor=Address;
            return string(abi.encodePacked("update ",Location," successfully"));
    }
    function getData(string calldata Location) public view returns (InstantInformation memory){
        require(ForecastData[Location].isValue==true,"Please make sure you typing right location name");
        return ForecastData[Location];
    }
}