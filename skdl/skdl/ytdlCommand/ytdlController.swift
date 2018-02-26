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
    
    internal var isAvailable = true
    
    // 增加对 可用和不可用的时候的一个处理
    
    fileprivate init() {}
    
    //MARK:- api
    
    internal func isURLAvailable(url: String) -> Bool {
        let args = [YOS.GetUrl, url, YON.SocketTimeout, PV.socketTimeout!]
        let commandResult = ytdlCommand.commandWaitingForResult(args: args)
        if commandResult.result == "" {
            return false
        }
        return true
    }
    
    internal func isURLAvailableInProxy(url: String) -> Bool {
        let args = [YOS.GetUrl, url, YON.Proxy, Preference.proxy]
        let commandResult = ytdlCommand.commandWaitingForResult(args: args)
        if commandResult.result == "" {
            return false
        }
        return true
    }
    
    // batch
    internal func dumpJson(urls: [String], _ isProxyUrl: Bool = false) -> [String]? {
        var args = [YOS.DumpJson]
        args.append(contentsOf: urls)
        if isProxyUrl {
            args.append(contentsOf: [YON.Proxy, Preference.proxy])
        }
        
        let commandResult = ytdlCommand.commandWaitingForResult(args: args)
        let jsons = commandResult.result?.components(separatedBy: "\n")
        return jsons
    }
    
    internal func dumpJson(url: String, _ isProxyUrl: Bool = false) -> String? {
        var args = [YOS.DumpJson]
        args.append(url)
        if isProxyUrl {
            args.append(contentsOf: [YON.Proxy, Preference.proxy])
        }
        let commandResult = ytdlCommand.commandWaitingForResult(args: args)
        
      //  if commandResult.errorMessage?.isEmpty
        
        return commandResult.result
    }
    
    internal func download(with url: String, localPath: String, isProxyUrl: Bool = false) -> ytdlCommand.Handle {
        var args = [YOF.Output, localPath, url]
        if isProxyUrl {
            args.append(contentsOf: [YON.Proxy, Preference.proxy])
        }
        return ytdlCommand.command(args: args)
    }
    
    // todo
    // 没有做对于youtube-dl升级的时候做的事
    internal func update() {
        DispatchQueue.global().async {
            self.isAvailable = false
            _ = ytdlCommand.commandWaitingForResult(args: [YO.Update])
            self.isAvailable = true
        }
    }
    
    internal func version() -> String? {
        let args = [YO.Version]
        
        let commandResult = ytdlCommand.commandWaitingForResult(args: args)
        
        guard let version = commandResult.result  else {
            print("version is nil!")
            return nil
        }
        return version
    }
    
}
