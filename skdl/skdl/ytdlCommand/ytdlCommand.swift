//
//  ytdlCommand.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation



class ytdlCommand {
    
    static func command(args: [String]?) -> String? {
        let ytdlPath = getYTDLPathFromSKDL()
        let task = Process()
        task.launchPath = ytdlPath
        task.arguments = args
        let out = Pipe()
        task.standardOutput = out
        task.launch()
        let fileHandle = out.fileHandleForReading
        return String(data: fileHandle.readDataToEndOfFile(), encoding: .utf8)
    }
    
    static fileprivate func getYTDLPathFromSKDL() -> String? {
        return Bundle.main.path(forResource: "youtube-dl", ofType: "")
    }
    
}
