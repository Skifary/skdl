//
//  ErrorReport.swift
//  skdl
//
//  Created by Skifary on 12/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

public class ErrorReport {
    
    public static func fatal(_ message: String, _ block: () -> Void = {}) -> Never {
        Log.logWithCallStack(message)
        Alert.criticize("fatal_error", message)
        block()
        exit(1)
    }

}
