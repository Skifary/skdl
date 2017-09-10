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
    
    func dumpJson(urls: [String]) -> [String]? {
        var args = [YOS.kDumpJson]
        args.append(contentsOf: urls)
        let res = ytdlCommand.command(args: args)
        let jsons = res?.components(separatedBy: "\n")
        return jsons
    }
    
    func download(url: String, localPath: String) {
        
    }
    
}
