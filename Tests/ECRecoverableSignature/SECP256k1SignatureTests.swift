//
// This source file is part of the Web3Swift.io open source project
// Copyright 2018 The Web3Swift Authors
// Licensed under Apache License v2.0
//
// SECP256k1SignatureTests.swift
//
// Created by Timofey Solonin on 10/05/2018
//

import Foundation

import CryptoSwift
import Nimble
import Quick
@testable import Web3Swift
import XCTest

//FIXME: SigningError case is not tested
//FIXME: SignatureSerializationError case is not tested
//FIXME: A lot of copy paste tests.
final class SECP256k1SignatureTests: XCTestCase {

    private let validPrivateKey: PrivateKey = {
        EthPrivateKey(
            bytes: BytesFromHexString(
                hex: "bdd61bcde5541ac8ad18c0ec53356419a0e62e8f147a1cc16ea36799e2cc64dd"
            )
        )
    }()

    func testEqualSignatures() {
        let firstSignature = SECP256k1Signature(
            digest: Keccak256Bytes(
                origin: UTF8StringBytes(
                    string: "Hello world"
                )
            ),
            privateKey: self.validPrivateKey
        )
        let secondSignature = SECP256k1Signature(
            digest: Keccak256Bytes(
                origin: UTF8StringBytes(
                    string: "Hello world"
                )
            ),
            privateKey: self.validPrivateKey
        )
        expect{
            expect(
                try firstSignature.r().value()
            ).to(
                equal(
                    try secondSignature.r().value()
                ),
                description: "Two signatures with equal messages must have equal r values"
            )
            expect(
                try firstSignature.s().value()
            ).to(
                equal(
                    try secondSignature.s().value()
                ),
                description: "Two signatures with equal messages must have equal s values"
            )
            expect(
                try firstSignature.recoverID().value()
            ).to(
                equal(
                    try secondSignature.recoverID().value()
                ),
                description: "Two signatures with equal messages must have equal recovery id values"
            )
            return ()
        }.toNot(
            throwError(),
            description: "None of the above statements are expected to throw"
        )
    }

    func testDifferentMessages() {
        let firstSignature = SECP256k1Signature(
            digest: Keccak256Bytes(
                origin: UTF8StringBytes(
                    string: "Hello world"
                )
            ),
            privateKey: self.validPrivateKey
        )
        let secondSignature = SECP256k1Signature(
            digest: Keccak256Bytes(
                origin: UTF8StringBytes(
                    string: "Hello worlds"
                )
            ),
            privateKey: self.validPrivateKey
        )
        expect{
            try firstSignature.r().value() == secondSignature.r().value()
                && firstSignature.s().value() == secondSignature.s().value()
                && firstSignature.recoverID().value() == secondSignature.recoverID().value()
        }.to(
            equal(false),
            description: "Signatures with different messages must be different"
        )
    }

    /// Assert example from EIP-155 matches SECP256k1Signature implementation
    func testOneRawMessage() {
        let signature = SECP256k1Signature(
            digest: Keccak256Bytes(
                origin: BytesFromHexString(
                    hex: "0xec098504a817c800825208943535353535353535353535353535353535353535880de0b6b3a764000080018080"
                )
            ),
            privateKey: EthPrivateKey(
                bytes: BytesFromHexString(
                    hex: "0x4646464646464646464646464646464646464646464646464646464646464646"
                )
            )
        )
        expect{
            try signature.r().value()
        }.to(
            equal(
                Data(hex: "0x28ef61340bd939bc2195fe537567866003e1a15d3c71ff63e1590620aa636276")
            ),
            description: "Signature r is expected to match example r"
        )
        expect{
            try signature.s().value()
        }.to(
            equal(
                Data(hex: "0x67cbe9d8997f761aecb703304b3800ccf555c9f3dc64214b297fb1966a3b6d83")
            ),
            description: "Signature s is expected to match example s"
        )
    }

    /// Assert example from EIP-155 matches SECP256k1Signature implementation dependent upon SimpleRLP implementation
    func testOneRLP() {
        let signature = SECP256k1Signature(
            digest: Keccak256Bytes(
                origin: SimpleRLP(
                    rlps: [
                        SimpleRLP(
                            bytes: Data(
                                hex: "0x09" //nonce
                            )
                        ),
                        SimpleRLP(
                            bytes: Data(
                                hex: "0x04a817c800" //gas price
                            )
                        ),
                        SimpleRLP(
                            bytes: Data(
                                hex: "0x5208" //start gas
                            )
                        ),
                        SimpleRLP(
                            bytes: Data(
                                hex: "0x3535353535353535353535353535353535353535" //to
                            )
                        ),
                        SimpleRLP(
                            bytes: Data(
                                hex: "0x0de0b6b3a7640000" //value
                            )
                        ),
                        SimpleRLP(
                            bytes: Data() //data
                        ),
                        SimpleRLP(
                            bytes: Data(
                                hex: "0x01" //chain id (mainnet in this case)
                            )
                        ),
                        SimpleRLP(
                            bytes: Data() //stubbed r according to EIP-155
                        ),
                        SimpleRLP(
                            bytes: Data() //stubbed s according to EIP-155
                        ),
                    ]
                )
            ),
            privateKey: EthPrivateKey(
                bytes: BytesFromHexString(
                    hex: "0x4646464646464646464646464646464646464646464646464646464646464646"
                )
            )
        )
        expect{
            try signature.r().value()
        }.to(
            equal(
                Data(hex: "0x28ef61340bd939bc2195fe537567866003e1a15d3c71ff63e1590620aa636276")
            ),
            description: "Signature r is expected to match example r"
        )
        expect{
            try signature.s().value()
        }.to(
            equal(
                Data(hex: "0x67cbe9d8997f761aecb703304b3800ccf555c9f3dc64214b297fb1966a3b6d83")
            ),
            description: "Signature s is expected to match example s"
        )
    }

}
