//
//  MessageAlert.swift
//  skdl
//
//  Created by Skifary on 13/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


class MessageAlert {
    
    static func show(title: String, message: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message;
        alert.alertStyle = .warning
        alert.runModal()
    }
    
    static func assert(_ expr: Bool, _ errorMessage: String, _ block: () -> Void = {}) {
        if !expr {
            NSLog("%@", errorMessage)
            show(title: "fatal_error", message: errorMessage)
            block()
            exit(1)
        }
    }
    
    static func fatal(_ message: String, _ block: () -> Void = {}) -> Never {
        NSLog("%@\n", message)
        NSLog(Thread.callStackSymbols.joined(separator: "\n"))
        show(title: "fatal_error", message: message)
        block()
        // Exit without crash since it's not uncatched/unhandled
        exit(1)
    }
    
    static func log(_ message: String) {
        NSLog("%@", message)
    }
}
