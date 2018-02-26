//
//  Shell.swift
//  skdl
//
//  Created by Skifary on 02/02/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Foundation

class Shell {
    
    static func excuteCommand(_ command: String) -> String? {
        let process = Process()
        
        let info = ProcessInfo.processInfo
        process.environment = info.environment
        
        process.launchPath = info.environment["SHELL"]
        process.arguments = ["-l","-c",command]
        let out = Pipe()
        process.standardOutput = out
        let error = Pipe()
        process.standardError = error
        process.launch()
        let errorMessage = String(data: error.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        if errorMessage != "" {
            print(errorMessage!)
            return nil
        }
        return String(data: out.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
    }
    
}
