//
//  LogInitializer.swift
//  Web3Swift
//
//  Created by Ken on 6/11/19.
//  Copyright © 2019 Computable Labs, LLC. All rights reserved.
//

import Foundation
import SwiftyBeaver

class Logger {

    private static let log = SwiftyBeaver.self
    private static var initialized = false
        
    static func debug(_ message: Any) {
        if !initialized {
            initializeLogger()
        }
        log.debug(message)
    }
    
    static func info(_ message: Any) {
        if !initialized {
            initializeLogger()
        }
        log.info(message)
    }
    
    static func info(_ message: Any, _ context: Any?) {
        if !initialized {
            initializeLogger()
        }
        log.info(message, context: context)
    }
    
    static func warn(_ message: Any) {
        if !initialized {
            initializeLogger()
        }
        log.warning(message)
    }
    
    static func warn(_ message: Any, _ context: Any?) {
        if !initialized {
            initializeLogger()
        }
        log.warning(message, context: context)
    }
    
    static func error(_ message: Any) {
        if !initialized {
            initializeLogger()
        }
        log.debug(message)
    }
    
    static func error(_ message: Any, _ context: Any?) {
        if !initialized {
            initializeLogger()
        }
        log.error(message, context: context)
    }
    
    private static func initializeLogger() {
        let console = ConsoleDestination()
        //let file = FileDestination()  // log to default swiftybeaver.log file
        //let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123")
        
        console.format = "$DHH:mm:ss$d $L $M"
        // or use this for JSON output: console.format = "$J"
        
        // add the destinations to SwiftyBeaver
        log.addDestination(console)
        //log.addDestination(file)
        //log.addDestination(cloud)
        initialized = true
    }
    
}
