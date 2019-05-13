//
// This source file is part of the Web3Swift.io open source project.
// Copyright 2018 The Web3Swift Authors.
// Licensed under Apache License v2.0
//
// QuantityParameterTests.swift
//
// Created by Vadim Koleoshkin on 21/02/2018
//

import Nimble
import Quick
@testable import Web3Swift
import XCTest

class QuantityParameterTests: XCTestCase {
    
    /// Assert parameter returns correct hex string
    func testQuantityParameterToString() {
        expect{
            try QuantityParameter(
                number: EthNumber(
                    value: 1
                )
            ).value() as? String
        }.to(
            equal("0x1"),
            description: "Make sure that correct hex string is returned"
        )
    }

    func testZeroIsEncodedCorrectly() {
        expect{
            try QuantityParameter(
                number: EthNumber(
                    value: 0
                )
            ).value() as? String
        }.to(
            equal(
                "0x0"
            ),
            description: "Zero is expected to represented correctly"
        )
    }

}
