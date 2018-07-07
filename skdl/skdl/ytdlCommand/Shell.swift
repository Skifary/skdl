//
//  Shell.swift
//  skdl
//
//  Created by Skifary on 02/02/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Foundation

class Shell {
    
    static func excuteCommand(_ command: String, _ otherEnvironment : [String : String]? = nil) -> String? {
        let process = Process()
        
        let info = ProcessInfo.processInfo
        var environment : [String : String] = info.environment
        
        if let otherEnvironment = otherEnvironment {
            otherEnvironment.forEach { (key, value) in
                environment[key] = value
            }
        }
        process.environment = environment
        
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
        
        guard let ret = String(data: out.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            return nil
        }
        
        if ret.isEmpty {
            return nil
        }
        return ret
    }
    
}
