//
// This source file is part of the Web3Swift.io open source project
// Copyright 2018 The Web3Swift Authors
// Licensed under Apache License v2.0
//
// ContractCallProcedureTests.swift
//
// Created by Timofey Solonin on 10/05/2018
//

import Nimble
import Quick
@testable import Web3Swift

final class ContractCallProcedureTests: XCTestCase {

    //let network = MainnetInfuraNetwork()
    let network = GethNetwork(url: "http://127.0.0.1:8545")
    //let ethAddress = "0x86fa049857e0209aa7d9e616f7eb3b3b78ecfdb0"
    let ethAddress = "0x77dc2A86f789F7FD6AabF446FB56f6F63ed24cEe"
    
    func testEOSSupply() {
        expect{
            try ContractCallProcedure(
                network: self.network,
                parameters: [
                    "to" : BytesParameter(bytes: EthAddress(hex: self.ethAddress)),
                    "data" : BytesParameter(
                        bytes: EncodedABIFunction(
                            signature: SimpleString(
                                string: "totalSupply()"
                            ),
                            parameters: []
                        )
                    )
                ]
            ).call()["result"].string()
        }.to(
            equal(
                "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
            ),
            description: "EOS supply is expected to be 1,000,000,000 represented in abi encoded hex number"
        )
    }

}
