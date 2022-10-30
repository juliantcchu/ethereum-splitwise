// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
// DO NOT MODIFY ABOVE THIS
// ADD YOUR CONTRACT CODE BELOW

    // database for all IOUs
    mapping(address => mapping(address => uint32)) public IOUs;

    // lookup function for IOU amounts
    function lookup(address debtor, address creditor) public view returns (uint32 ret) {
        return IOUs[debtor][creditor];
    }

    // add IOU and remove cycle by cycleAmount if exist
    function add_IOU(address creditor, uint32 amount, address[] memory cycle, uint32 cycleAmount ) public {
        IOUs[msg.sender][creditor] = amount;

        //resolve cycle if exist
        for (uint32 i; i < cycle.length; i++){
            require(IOUs[cycle[i]][cycle[i+1 % cycle.length]] >= cycleAmount);
            IOUs[cycle[i]][cycle[i+1 % cycle.length]] -= cycleAmount;
        }
    }

}




// contract Splitwise {
// // DO NOT MODIFY ABOVE THIS
// // ADD YOUR CONTRACT CODE BELOW

//     mapping(address => mapping(address => uint32)) public IOUs;

//     mapping(address => address[]) public creditors;

//     function lookup(address debtor, address creditor) public view returns (uint32 ret) {
//         return IOUs[debtor][creditor];
//     }

//     function add_IOU(address creditor, uint32 amount, uint32[] memory cycle, 
//                         uint32 cycleAmount, bool addCreditor) public {


//         // add IOU
//         IOUs[msg.sender][creditor] = amount;
//         if (addCreditor){
//             creditors[msg.sender].push(creditor);
//         }

//         //resolve cycle if exist
//         address currDebtor = msg.sender;
//         for (uint32 i; i < cycle.length; i++){
//             address currCreditor = creditors[currDebtor][cycle[i]];

//             require(IOUs[currDebtor][currCreditor] >= cycleAmount);
//             IOUs[currDebtor][currCreditor] -= cycleAmount;
            
//             // remove from creditor list
//             if (IOUs[currDebtor][currCreditor] == 0){
//                 if (creditors[currDebtor].length - 1 != cycle[i]){
//                     //put last element in place of curr elem
//                     creditors[currDebtor][cycle[i]] = creditors[currDebtor][creditors[currDebtor].length - 1];
//                 }
//                 creditors[currDebtor].pop();
//             }

//             currDebtor = creditor;
//         }
//     }

// }
