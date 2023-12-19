// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0 ;

struct Candidate{ //ผู้ลงสมัครเลือกตั้ง
    string name ; //ชื่อผู้สมัคร
    uint voteCount ; //จำนวนผู้ลงคะแนน
}
struct Voter{
    bool isRegister ; //ค่าเริ่มต้นเป็น False เมื่อเป็น True หลังจาก Register แล้วจะสามารถลงคะแนนได้
    bool isVoted ;  //สถานะการลงคะแนน ยังไม่เคยเลือก False เลือกแล้ว True (1 คน เลือก 1 ครั้ง)
    uint voteIndex ;
}
contract Election{
    //ผู้จัดการการเลือกตั้ง
    address public manager ;  
    Candidate [] public  candidates ;
    mapping(address => Voter) public  voter ;
    constructor(){
        manager = msg.sender ;
    }
    modifier onlyManager{
        require(msg.sender == manager, "You Not Manager !");
        _ ;
    }
    function addCandidate(string memory name) onlyManager public{
        candidates.push(Candidate(name,0)); //เพิ่มข้อมูลผู้สมัครโดยมีค่าเริ่มต้นเป็น 0
    }
    function register(address person) onlyManager public { //Onlymanager
            voter[person].isRegister = true ;
    }
    //คะแนนเลือกตั้ง
    function vote(uint index) public {
        require(voter[msg.sender].isRegister,"You Not Register !");
        require(!voter[msg.sender].isVoted,"You Are Elected !"); //เคยเลือกตั้งไปแล้วไม่สามารถโหวตซ้ำได้
        voter[msg.sender].voteIndex = index ;
        voter[msg.sender].isVoted = true ;
        candidates[index].voteCount+=1 ;
    }

}

/*
i = index
Party
1(i=0) = Pitan 
2(i=1) = Pima
3(i=2) = Prayuan

address = ID Identify
*/