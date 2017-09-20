//
//  ytdlCommand.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation



class ytdlCommand {
    
    static func singleCommand(args: [String]?) -> (result: String?,errorMessage: String?) {
        let res = command(args: args)
        res.task.launch()
        let errorMessage = String(data: res.error.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        let result = String(data: res.out.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        return (result,errorMessage)
    }
    
    static func command(args: [String]?) -> (task: Process, out: Pipe, error: Pipe) {
        let ytdlPath = getYTDLPathFromSKDL()
        let task = Process()
        task.launchPath = ytdlPath
        task.arguments = args
        let out = Pipe()
        task.standardOutput = out
        let error = Pipe()
        task.standardError = error
        return (task, out, error)
    }
    
    static fileprivate func getYTDLPathFromSKDL() -> String? {
        return Bundle.main.path(forResource: "youtube-dl", ofType: "")
    }
    
}
