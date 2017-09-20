//
//  ytdlController.swift
//  skdl
//
//  Created by Skifary on 08/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation




class ytdlController {
    
    //MARK:- singleton
    static let shared = ytdlController()
    
    fileprivate init() {
        
    }
    
    //MARK:- api
    
    func isUrlAvailable(url: String) -> Bool {
        let args = [YOS.kGetUrl, url]
        let res = ytdlCommand.singleCommand(args: args)
        if res.result == "" {
            return false
        }
        return true
    }
    
    func dumpJson(urls: [String]) -> [String]? {
        var args = [YOS.kDumpJson]
        args.append(contentsOf: urls)
        let res = ytdlCommand.singleCommand(args: args)
        let jsons = res.result?.components(separatedBy: "\n")
        return jsons
    }
    
    func download(url: String, localPath: String) -> (task: Process, out: Pipe, error: Pipe) {
       return ytdlCommand.command(args: [YOF.kOutput, localPath, url])
    }
    
}
