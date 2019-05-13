//
// This source file is part of the Web3Swift.io open source project
// Copyright 2018 The Web3Swift Authors
// Licensed under Apache License v2.0
//
// EthTransactionBytesTests.swift
//
// Created by Timofey Solonin on 10/05/2018
//

import CryptoSwift
import Nimble
import Quick
@testable import Web3Swift

final class EthTransactionBytesTests: XCTestCase {

    func testStaticParametersAreSignedCorrectly() {
        expect{
            return try EthTransactionBytes(
                networkID: SimpleInteger(
                    integer: 42
                ),
                transactionsCount: EthNumber(
                    value: 0
                ),
                gasPrice: EthNumber(
                    hex: SimpleString(
                        string: "0x06FC23AC00"
                    )
                ),
                gasEstimate: EthNumber(
                    value: 21000
                ),
                senderKey: EthPrivateKey(
                    bytes: BytesFromHexString(
                        hex: "0x1636e10756e62baabddd4364010444205f1216bdb1644ff8f776f6e2982aa9f5"
                    )
                ),
                recipientAddress: BytesFromHexString(
                    hex: "0xcD8aC90d9cc7e4c03430d58d2f3e87Dae70b807e"
                ),
                weiAmount: EthNumber(
                    hex: SimpleString(
                        string: "0xE8D4A51000"
                    )
                ),
                contractCall: EmptyBytes()
            ).value().toHexString()
        }.to(
            equal("f869808506fc23ac0082520894cd8ac90d9cc7e4c03430d58d2f3e87dae70b807e85e8d4a510008078a0be0f8648eb3ac495916ae251dae74c6339ff211dcad7b355280b64b3c2746a91a021ed29b918d61cfda1bb5c9dd0c708643308ec38afe5ae224fe1eb010fed042e"),
            description: "The above transaction is expected to be correctly signed"
        )
    }

    func test129thTransactionIsSignedCorrectly() {
        expect{
            return try EthTransactionBytes(
                networkID: SimpleInteger(
                    integer: 1
                ),
                transactionsCount: EthNumber(
                    value: 128
                ),
                gasPrice: EthNumber(
                    hex: SimpleString(
                        string: "0x04A817C800"
                    )
                ),
                gasEstimate: EthNumber(
                    value: 21000
                ),
                senderKey: Tim().privateKey(),
                recipientAddress: Alice().address(),
                weiAmount: EthNumber(
                    hex: SimpleString(
                        string: "0x01"
                    )
                ),
                contractCall: EmptyBytes()
            ).value().toHexString()
        }.to(
            equal(
                "f86581808504a817c80082520894cd8ac90d9cc7e4c03430d58d2f3e87dae70b807e018026a00f577abf16807cf9a79e0451c80ba7ee5d847234c3d775ea87a008b587eda933a0518e3b6008ead901fdda1acca7d8f003633c50934f12721d76d6d67558449ab3"
            ),
            description: "The above transaction with a nonce of 128 is expected to be correctly signed"
        )
    }

}
