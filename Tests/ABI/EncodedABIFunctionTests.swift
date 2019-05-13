//
// This source file is part of the Web3Swift.io open source project
// Copyright 2018 The Web3Swift Authors
// Licensed under Apache License v2.0
//
// EncodedABIFunctionTests.swift
//
// Created by Timofey Solonin on 10/05/2018
//

import CryptoSwift
import Nimble
import Quick
@testable import Web3Swift

//swiftlint:disable file_length
//swiftlint:disable function_body_length

final class EncodedABIFunctionTests: XCTestCase {

    func testStringContucton() {
        expect{
            try EncodedABIFunction(
                signature: "baz(uint32,bool)",
                parameters: [
                    ABIAddress(
                        address: EthAddress(
                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1"
                        )
                    )
                ]
            ).value()
        }.to(
                equal(
                    Data(
                        hex: "cdcd77c0" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c1"
                    )
                ),
                description: "Selector + address is expected to be encoded correctly"
        )
    }
    
    func testTwoDimensionalDynamicArrayOfTwoEncoding() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIDynamicCollection(
                        parameters: [
                            ABIDynamicCollection(
                                parameters: [
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c5"
                                        )
                                    )
                                ]
                            ),
                            ABIDynamicCollection(
                                parameters: [
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c3"
                                        )
                                    )
                                ]
                            )
                        ]
                    ),
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "0000000000000000000000000000000000000000000000000000000000000020" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "0000000000000000000000000000000000000000000000000000000000000040" +
                        "0000000000000000000000000000000000000000000000000000000000000080" +
                        "0000000000000000000000000000000000000000000000000000000000000001" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c5" +
                        "0000000000000000000000000000000000000000000000000000000000000001" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c3"
                )
            ),
            description: "Selector + address[][] is expected to be encoded correctly"
        )
    }

    func testTwoDimensionalDynamicArrayOfFourEncoding() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIDynamicCollection(
                        parameters: [
                            ABIDynamicCollection(
                                parameters: [
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100cf"
                                        )
                                    ),
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c2"
                                        )
                                    )
                                ]
                            ),
                            ABIDynamicCollection(
                                parameters: [
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c3"
                                        )
                                    ),
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c4"
                                        )
                                    )
                                ]
                            )
                        ]
                    ),
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "0000000000000000000000000000000000000000000000000000000000000020" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "0000000000000000000000000000000000000000000000000000000000000040" +
                        "00000000000000000000000000000000000000000000000000000000000000a0" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100cf" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c2" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c3" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c4"
                )
            ),
            description: "Selector + address[][] is expected to be encoded correctly"
        )
    }

    func testSingleAddress() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIAddress(
                        address: EthAddress(
                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1"
                        )
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c1"
                )
            ),
            description: "Selector + address is expected to be encoded correctly"
        )
    }

    func testAddressFixedArrayOfTwo() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABITuple(
                        parameters: [
                            ABIAddress(
                                address: EthAddress(
                                    hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1"
                                )
                            ),
                            ABIAddress(
                                address: EthAddress(
                                    hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c3"
                                )
                            )
                        ]
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c1" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c3"
                )
            ),
            description: "Selector + address[2] is expected to be encoded correctly"
        )
    }
    
    func testTwoAddressFixedArraysOfTwo() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABITuple(
                        parameters: [
                            ABITuple(
                                parameters: [
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1"
                                        )
                                    ),
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c2"
                                        )
                                    )
                                ]
                            ),
                            ABITuple(
                                parameters: [
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c3"
                                        )
                                    ),
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c4"
                                        )
                                    )
                                ]
                            )
                        ]
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c1" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c2" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c3" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c4"
                )
            ),
            description: "Selector + address[2][2] is expected to be encoded correctly"
        )
    }

    func testAddressDynamicArrayOfTwo() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIDynamicCollection(
                        parameters: [
                            ABIAddress(
                                address: EthAddress(
                                    hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1"
                                )
                            ),
                            ABIAddress(
                                address: EthAddress(
                                    hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c3"
                                )
                            )
                        ]
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "0000000000000000000000000000000000000000000000000000000000000020" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c1" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c3"
                )
            ),
            description: "Selector + address[] is expected to be encoded correctly"
        )
    }

    func testAddressStaticArrayOfDynamicArraysOf2() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIDynamicCollection(
                        parameters: [
                            ABIAddress(
                                address: EthAddress(
                                    hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1"
                                )
                            ),
                            ABIAddress(
                                address: EthAddress(
                                    hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c2"
                                )
                            )
                        ]
                    ),
                    ABIDynamicCollection(
                        parameters: [
                            ABIAddress(
                                address: EthAddress(
                                    hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c3"
                                )
                            ),
                            ABIAddress(
                                address: EthAddress(
                                    hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c4"
                                )
                            )
                        ]
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "0000000000000000000000000000000000000000000000000000000000000040" +
                        "00000000000000000000000000000000000000000000000000000000000000a0" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c1" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c2" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c3" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c4"
                )
            ),
            description: "Selector + address[][2] is expected to be encoded correctly"
        )
    }

    func testAddressDynamicArrayOfStaticArraysOf2() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIDynamicCollection(
                        parameters: [
                            ABITuple(
                                parameters: [
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1"
                                        )
                                    ),
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c2"
                                        )
                                    )
                                ]
                            ),
                            ABITuple(
                                parameters: [
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c3"
                                        )
                                    ),
                                    ABIAddress(
                                        address: EthAddress(
                                            hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c4"
                                        )
                                    )
                                ]
                            )
                        ]
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "0000000000000000000000000000000000000000000000000000000000000020" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c1" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c2" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c3" +
                        "000000000000000000000000407d73d8a49eeb85d32cf465507dd71d507100c4"
                )
            ),
            description: "Selector + address[2][] is expected to be encoded correctly"
        )
    }

    func testFixedBytesAndVariableBytes() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIFixedBytes(
                        origin: BytesFromHexString(
                            hex: "0xcf0011"
                        )
                    ),
                    ABIVariableBytes(
                        origin: BytesFromHexString(
                            hex: "0x4d00000000000000000000000000000000000000000000000000000000000012"
                        )
                    )
                ]
            ).value().toHexString()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "cf00110000000000000000000000000000000000000000000000000000000000" +
                        "0000000000000000000000000000000000000000000000000000000000000040" +
                        "0000000000000000000000000000000000000000000000000000000000000020" +
                        "4d00000000000000000000000000000000000000000000000000000000000012"
                ).toHexString()
            ),
            description: "Selector + bytes3, bytes is expected to be encoded correctly"
        )
    }

    func testNumberBytesNumberBytes() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIUnsignedNumber(
                        origin: EthNumber(
                            value: 5
                        )
                    ),
                    ABIVariableBytes(
                        origin: BytesFromHexString(
                            hex: "0x131a3afc00d1b1e3461b955e53fc866dcf303b3eb9f4c16f89e388930f48134b231a3afc00d1b1e3461b955e53fc866dcf303b3eb9f4c16f89e388930f48134b"
                        )
                    ),
                    ABIUnsignedNumber(
                        origin: EthNumber(
                            value: 3
                        )
                    ),
                    ABIVariableBytes(
                        origin: BytesFromHexString(
                            hex: "0x331a3afc00d1b1e3461b955e53fc866dcf303b3eb9f4c16f89e388930f48134b431a3afc00d1b1e3461b955e53fc866dcf303b3eb9f4c16f89e388930f48134b"
                        )
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "0000000000000000000000000000000000000000000000000000000000000005" +
                        "0000000000000000000000000000000000000000000000000000000000000080" +
                        "0000000000000000000000000000000000000000000000000000000000000003" +
                        "00000000000000000000000000000000000000000000000000000000000000e0" +
                        "0000000000000000000000000000000000000000000000000000000000000040" +
                        "131a3afc00d1b1e3461b955e53fc866dcf303b3eb9f4c16f89e388930f48134b" +
                        "231a3afc00d1b1e3461b955e53fc866dcf303b3eb9f4c16f89e388930f48134b" +
                        "0000000000000000000000000000000000000000000000000000000000000040" +
                        "331a3afc00d1b1e3461b955e53fc866dcf303b3eb9f4c16f89e388930f48134b" +
                        "431a3afc00d1b1e3461b955e53fc866dcf303b3eb9f4c16f89e388930f48134b"
                )
            ),
            description: "Selector + int, bytes, int, bytes is expected to be encoded correctly"
        )
    }

    func testNumberBytesNumberNumberNumberDynamicNumbersArray() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIUnsignedNumber(
                        origin: EthNumber(
                            value: 1
                        )
                    ),
                    ABIString(
                        origin: SimpleString(
                            string: "gavofyork"
                        )
                    ),
                    ABIUnsignedNumber(
                        origin: EthNumber(
                            value: 2
                        )
                    ),
                    ABIUnsignedNumber(
                        origin: EthNumber(
                            value: 3
                        )
                    ),
                    ABIUnsignedNumber(
                        origin: EthNumber(
                            value: 4
                        )
                    ),
                    ABIDynamicCollection(
                        parameters: [
                            ABIUnsignedNumber(
                                origin: EthNumber(
                                    value: 5
                                )
                            ),
                            ABIUnsignedNumber(
                                origin: EthNumber(
                                    value: 6
                                )
                            ),
                            ABIUnsignedNumber(
                                origin: EthNumber(
                                    value: 7
                                )
                            )
                        ]
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "0000000000000000000000000000000000000000000000000000000000000001" +
                        "00000000000000000000000000000000000000000000000000000000000000c0" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "0000000000000000000000000000000000000000000000000000000000000003" +
                        "0000000000000000000000000000000000000000000000000000000000000004" +
                        "0000000000000000000000000000000000000000000000000000000000000100" +
                        "0000000000000000000000000000000000000000000000000000000000000009" +
                        "6761766f66796f726b0000000000000000000000000000000000000000000000" +
                        "0000000000000000000000000000000000000000000000000000000000000003" +
                        "0000000000000000000000000000000000000000000000000000000000000005" +
                        "0000000000000000000000000000000000000000000000000000000000000006" +
                        "0000000000000000000000000000000000000000000000000000000000000007"
                )
            ),
            description: "Selector + int, string, int, int, int, int[] is expected to be encoded correctly"
        )
    }

    func testTwoDynamicIntArrays() {
        expect{
            try EncodedABIFunction(
                signature: SimpleString(
                    string: "baz(uint32,bool)"
                ),
                parameters: [
                    ABIDynamicCollection(
                        parameters: [
                            ABIUnsignedNumber(
                                origin: EthNumber(
                                    value: 1
                                )
                            ),
                            ABIUnsignedNumber(
                                origin: EthNumber(
                                    value: 2
                                )
                            )
                        ]
                    ),
                    ABIDynamicCollection(
                        parameters: [
                            ABIUnsignedNumber(
                                origin: EthNumber(
                                    value: 3
                                )
                            ),
                            ABIUnsignedNumber(
                                origin: EthNumber(
                                    value: 4
                                )
                            )
                        ]
                    )
                ]
            ).value()
        }.to(
            equal(
                Data(
                    hex: "cdcd77c0" +
                        "0000000000000000000000000000000000000000000000000000000000000040" +
                        "00000000000000000000000000000000000000000000000000000000000000a0" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "0000000000000000000000000000000000000000000000000000000000000001" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "0000000000000000000000000000000000000000000000000000000000000002" +
                        "0000000000000000000000000000000000000000000000000000000000000003" +
                        "0000000000000000000000000000000000000000000000000000000000000004"
                )
            ),
            description: "Selector + int[], int[] is expected to be encoded correctly"
        )
    }

    func test0xContractCallEncoding() {
        let kittiesContract = EthAddress(
            hex: "0x06012c8cf97bead5deae237070f9587f8e7a266d"
        )
        let sender = EthAddress(
            hex: "0x0aD9Fb61a07BAC25625382B63693644497f1B204"
        )
        let receiver = EthAddress(
            hex: "0x4dB6d56Bbb49DD66abC7be5D671fDdF9a5255Cc5"
        )
        let zero = EthAddress(
            hex: "0x0000000000000000000000000000000000000000"
        )
        let makerAssetData = RightZeroesPaddedBytes(
            origin: EncodedABIFunction(
                signature: SimpleString(
                    string: "ERC721Token(address,uint256)"
                ),
                parameters: [
                    ABIAddress(
                        address: kittiesContract
                    ),
                    ABIUnsignedNumber(
                        origin: EthNumber(value: 478404)
                    )
                ]
            ),
            padding: 32
        )
        let takerAssetData = RightZeroesPaddedBytes(
            origin: EncodedABIFunction(
                signature: SimpleString(
                    string: "ERC721Token(address,uint256)"
                ),
                parameters: [
                    ABIAddress(
                        address: kittiesContract
                    ),
                    ABIUnsignedNumber(
                        origin: EthNumber(value: 392919)
                    )
                ]
            ),
            padding: 32
        )
        let orderInfo = EncodedABIFunction(
            signature: SimpleString(
                string: "getOrderInfo((" +
                    "address," +
                    "address," +
                    "address," +
                    "address," +
                    "uint256," +
                    "uint256," +
                    "uint256," +
                    "uint256," +
                    "uint256," +
                    "uint256," +
                    "bytes," +
                "bytes))"
            ),
            parameters: [
                ABITuple(
                    parameters: [
                        // makerAddress
                        ABIAddress(
                            address: sender
                        ),
                        // takerAddress
                        ABIAddress(
                            address: receiver
                        ),
                        // feeRecipientAddress
                        ABIAddress(
                            address: zero
                        ),
                        // senderAddress
                        ABIAddress(
                            address: zero
                        ),
                        // makerAssetAmount
                        ABIUnsignedNumber(
                            origin: EthNumber(value: 1)
                        ),
                        // takerAssetAmount
                        ABIUnsignedNumber(
                            origin: EthNumber(value: 1)
                        ),
                        // makerFee
                        ABIUnsignedNumber(
                            origin: EthNumber(value: 0)
                        ),
                        // takerFee
                        ABIUnsignedNumber(
                            origin: EthNumber(value: 0)
                        ),
                        // expiration timestamp
                        ABIUnsignedNumber(
                            origin: EthNumber(
                                hex: "5c5f8a23"
                            )
                        ),
                        // salt
                        ABIFixedBytes(
                            origin: BytesFromHexString(
                                hex: "745a4c682985f13b4f6935e129e895a70737172437c4296d900c7b0a1b19354e"
                            )
                        ),
                        // makerAssetData
                        ABIVariableBytes(
                            origin: RightZeroesPaddedBytes(
                                origin: makerAssetData,
                                padding: 32
                            )
                        ),
                        // takerAssetData
                        ABIVariableBytes(
                            origin: RightZeroesPaddedBytes(
                                origin: takerAssetData,
                                padding: 32
                            )
                        )
                    ]
                )
            ]
        )
        expect{
            try PrefixedHexString(bytes: orderInfo).value()
        }.to(
            equal(
                "0xc75e0a81" +
                "0000000000000000000000000000000000000000000000000000000000000020" +
                "0000000000000000000000000ad9fb61a07bac25625382b63693644497f1b204" +
                "0000000000000000000000004db6d56bbb49dd66abc7be5d671fddf9a5255cc5" +
                "0000000000000000000000000000000000000000000000000000000000000000" +
                "0000000000000000000000000000000000000000000000000000000000000000" +
                "0000000000000000000000000000000000000000000000000000000000000001" +
                "0000000000000000000000000000000000000000000000000000000000000001" +
                "0000000000000000000000000000000000000000000000000000000000000000" +
                "0000000000000000000000000000000000000000000000000000000000000000" +
                "000000000000000000000000000000000000000000000000000000005c5f8a23" +
                "745a4c682985f13b4f6935e129e895a70737172437c4296d900c7b0a1b19354e" +
                "0000000000000000000000000000000000000000000000000000000000000180" +
                "0000000000000000000000000000000000000000000000000000000000000200" +
                "0000000000000000000000000000000000000000000000000000000000000060" +
                "0257179200000000000000000000000006012c8cf97bead5deae237070f9587f" +
                "8e7a266d00000000000000000000000000000000000000000000000000000000" +
                "00074cc400000000000000000000000000000000000000000000000000000000" +
                "0000000000000000000000000000000000000000000000000000000000000060" +
                "0257179200000000000000000000000006012c8cf97bead5deae237070f9587f" +
                "8e7a266d00000000000000000000000000000000000000000000000000000000" +
                "0005fed700000000000000000000000000000000000000000000000000000000"
            ),
            description: "0x contract call is expected to be encoded correctly"
        )
    }
    
}
