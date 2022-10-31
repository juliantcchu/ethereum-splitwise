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
        // console.log('curr amount', IOUs[msg.sender][creditor]);
        // console.log('amount to add', amount);
        IOUs[msg.sender][creditor] += amount;
        // console.log('new amount', IOUs[msg.sender][creditor]);


        //resolve cycle if exist
        // console.log(creditor,amount, cycle, cycleAmount );
        for (uint32 i = 0; i < cycle.length; i++){
            // console.log(i, cycle.length);
            // console.log('requirement', i, (i+1) % cycle.length);
            // console.log('requirement cont', IOUs[cycle[i]][cycle[(i+1) % cycle.length]]);
            require(IOUs[cycle[i]][cycle[(i+1) % cycle.length]] >= cycleAmount, 'cycleAmount too large');
            IOUs[cycle[i]][cycle[(i+1) % cycle.length]] -= cycleAmount;
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
