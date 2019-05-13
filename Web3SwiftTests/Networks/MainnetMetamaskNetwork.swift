//
// This source file is part of the Web3Swift.io open source project
// Copyright 2018 The Web3Swift Authors
// Licensed under Apache License v2.0
//
// MainnetInfuraNetwork.swift
//
// Created by Timofey Solonin on 10/05/2018
//

import Foundation
import Web3Swift

//Ethereum mainnet via infura service and a Web3Swift.io api key
public final class MainnetInfuraNetwork: Network {

    private let origin: Network = InfuraNetwork(chain: "mainnet", apiKey: "0c4d6dc730244b4185a6bde26f981bff")

    /**
    - returns:
    Id of a mainnet (should be 1)

    - throws:
    `DescribedError` if something went wrong
    */
    public func id() throws -> IntegerScalar {
        return try origin.id()
    }

    /**
    - returns:
    `Data` for a JSON RPC call to mainnet

    - throws:
    `DescribedError` if something went wrong
    */
    public func call(method: String, params: Array<EthParameter>) throws -> Data {
        return try origin.call(
            method: method,
            params: params
        )
    }

}
