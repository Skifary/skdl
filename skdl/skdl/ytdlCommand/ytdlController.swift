//
//  ytdlController.swift
//  skdl
//
//  Created by Skifary on 08/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal class ytdlController {
    
    //MARK:- singleton
    internal static let shared = ytdlController()
    
    fileprivate init() {
        
    }
    
    //MARK:- api
    
    internal func isURLAvailable(url: String) -> Bool {
        let args = [YOS.kGetUrl, url]
        let res = ytdlCommand.resultFromCommand(args: args)
        if res.result == "" {
            Log.logWithCallStack(res.errorMessage)
            return false
        }
        return true
    }
    
    internal func dumpJson(urls: [String]) -> [String]? {
        var args = [YOS.kDumpJson]
        args.append(contentsOf: urls)
        let res = ytdlCommand.resultFromCommand(args: args)
        let jsons = res.result?.components(separatedBy: "\n")
        return jsons
    }
    
    internal func dumpJson(url: String) -> String? {
        var args = [YOS.kDumpJson]
        args.append(url)
        let res = ytdlCommand.resultFromCommand(args: args)
        return res.result
    }
    
    internal func download(with url: String, localPath: String) -> (process: Process, out: Pipe, error: Pipe) {
       return ytdlCommand.command(args: [YOF.kOutput, localPath, url])
    }
    
}
