//
//  ytdlCommand.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal class ytdlCommand {
    
    internal static func resultFromCommand(args: [String]?) -> (result: String?,errorMessage: String?) {
        let res = command(args: args)
        res.process.launch()
        let errorMessage = String(data: res.error.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        let result = String(data: res.out.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        return (result,errorMessage)
    }
    
    internal static func command(args: [String]?) -> (process: Process, out: Pipe, error: Pipe) {
        let ytdlPath = getYTDLPathFromSKDL()
        let process = Process()
        process.launchPath = ytdlPath
        process.arguments = args
        let out = Pipe()
        process.standardOutput = out
        let error = Pipe()
        process.standardError = error
        return (process, out, error)
    }
    
    fileprivate static func getYTDLPathFromSKDL() -> String? {
        return Bundle.main.path(forResource: "youtube-dl", ofType: "")
    }
    
}
