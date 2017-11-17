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
        let args = [YOS.GetUrl, url, YON.SocketTimeout, PV.socketTimeout!]
        let res = ytdlCommand.resultFromCommand(args: args)
        if res.result == "" {
            Log.log(res.errorMessage)
            return false
        }
        return true
    }
    
    internal func isURLAvailableInProxy(url: String) -> Bool {
        let proxy: String = Preference.proxy
        let args = [YOS.GetUrl, url, YON.Proxy, proxy]
        let res = ytdlCommand.resultFromCommand(args: args)
        if res.result == "" {
            Log.log(res.errorMessage)
            return false
        }
        return true
    }
    
    internal func dumpJson(urls: [String], _ isProxyUrl: Bool = false) -> [String]? {
        var args = [YOS.DumpJson]
        args.append(contentsOf: urls)
        if isProxyUrl {
            args.append(YON.Proxy)
            args.append(Preference.proxy)
        }
        
        let res = ytdlCommand.resultFromCommand(args: args)
        let jsons = res.result?.components(separatedBy: "\n")
        return jsons
    }
    
    internal func dumpJson(url: String, _ isProxyUrl: Bool = false) -> String? {
        var args = [YOS.DumpJson]
        args.append(url)
        if isProxyUrl {
            print("append proxy1")
            args.append(YON.Proxy)
            args.append(Preference.proxy)
        }
        let res = ytdlCommand.resultFromCommand(args: args)
        return res.result
    }
    
    internal func download(with url: String, localPath: String, isProxyUrl: Bool = false) -> (process: Process, out: Pipe, error: Pipe) {
        var args = [YOF.Output, localPath, url]
        if isProxyUrl {
            print("append proxy2")
            
            print(Preference.proxy)
            args.append(YON.Proxy)
            args.append(Preference.proxy)
        }
        return ytdlCommand.command(args: args)
    }
    
}
