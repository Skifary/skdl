//
//  ytdlCommand.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal class ytdlCommand {
    
    typealias Handle = (process: Process, out: Pipe, error: Pipe)
    
    typealias Result = (result: String?,errorMessage: String?)
    
    internal static func commandWaitingForResult(args: [String]?) -> Result {
        let res = command(args: args)
        res.process.launch()
        let errorMessage = String(data: res.error.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        let result = String(data: res.out.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
        return (result,errorMessage)
    }
    
    internal static func command(args: [String]?) -> Handle {
        let ytdlPath = getYTDLPathFromSKDL()
        let process = Process()
        
        process.environment = ProcessInfo.processInfo.environment
        
       // process.environment!["PATH"] = "/Users/Skifary/miniconda3/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/go/bin:/Users/Skifary/Go/bin:/Users/Skifary/.rvm/bin"//[":/usr/local/bin:/usr/local/go/bin:/Users/Skifary/Go/bin:/Users/Skifary/.rvm/bin"]
//        if let path = Shell.excuteCommand("which ffmpeg") {
//
//            //添加 ffmpeg 来合并视频
//            process.environment!["PATH"]! += ":" + path.substring(to: path.count - 8)
//        }
//
        if let path = ffmpegPATH() {
            //添加 ffmpeg 来合并视频
            process.environment!["PATH"]! += ":" + path
        }
        
        process.launchPath = ytdlPath
        process.arguments = args
        let out = Pipe()
        process.standardOutput = out
        let error = Pipe()
        process.standardError = error
        return (process, out, error)
    }
    
    fileprivate static func getYTDLPathFromSKDL() -> String? {

        if !PV.useLocalYTDL {
            return builtinYTDLPath()
        }
        
        guard let path = systemYTDLPath() else {
            return builtinYTDLPath()
        }

        return path
    }
    
    fileprivate static func systemYTDLPath() -> String? {
        guard let path = Shell.excuteCommand("which youtube-dl") else {
            return nil
        }
        return path.substring(to: path.count - 2)
    }
    
    fileprivate static func builtinYTDLPath() -> String {
        return Bundle.main.path(forResource: "youtube-dl", ofType: "")!
    }
}
