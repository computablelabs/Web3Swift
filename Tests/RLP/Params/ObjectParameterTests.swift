//
// This source file is part of the Web3Swift.io open source project
// Copyright 2018 The Web3Swift Authors
// Licensed under Apache License v2.0
//
// ObjectParameterTests.swift
//
// Created by Vadim Koleoshkin on 23/02/2018
//

import Nimble
import Quick
@testable import Web3Swift
import XCTest

class ObjectParameterTests: XCTestCase {
    
    /// Assert object parameter does not throws an error
    func testValidObject() {
        expect{
            try ObjectParameter(
                dictionary: [
                    "from": BytesParameter(
                        bytes: Alice().address()
                    ),
                    "to": BytesParameter(
                        bytes: Bob().address()
                    ),
                    "gas": QuantityParameter(
                        number: EthNumber(
                            value: 9000
                        )
                    ),
                    "gasPrice": QuantityParameter(
                        number: EthNumber(
                            value: Int(pow(10.0, 9.0))
                        )
                    ),
                    "value": QuantityParameter(
                        number: EthNumber(
                            value: Int(pow(10.0, 18.0))
                        )
                    ),
                    "data": BytesParameter(
                        bytes: BytesFromHexString(
                            hex: "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"
                        )
                    )
                ]
            ).value()
        }.notTo(
            throwError(),
            description: "Make sure object does not throw an error"
        )
    }
    
}
