// works 2
//  ContractCompoents.swift
//  web3Interaction
//
//  Created by Mitchell Tucker on 5/14/21.
//works2

import Foundation

// Methods available within the contract
enum ContractMethods:  String {

    case projectContract = "write"
    case getProjectTitle = "read"
}

let contractAddress = "0xA4380435a13153C41658acC729B369Ddb84f5c11"

let contractABI =
    """
 [{"inputs":[],"name":"read","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"num","type":"uint256"}],"name":"write","outputs":[],"stateMutability":"nonpayable","type":"function"}]
"""

