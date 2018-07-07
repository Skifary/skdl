//
//  ytdlController.swift
//  skdl
//
//  Created by Skifary on 08/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal class ytdlController {
    
    typealias ytdlStatusChangedHandle = (Bool)->()
    
    //MARK:- singleton
    internal static let shared = ytdlController()
    
    internal var isUpdating = true {
        didSet {
            statusChangedHandles.forEach { (_, handle) in
                handle(isUpdating)
            }
        }
    }
    
    // 增加对 可用和不可用的时候的一个处理
    
    fileprivate var statusChangedHandles: [String : ytdlStatusChangedHandle] = [:]
    
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
            args.append(contentsOf: [YON.Proxy, Preference.proxy, YON.SocketTimeout, PV.socketTimeout])
        }
        let cmdResult = ytdlCommand.commandWaitingForResult(args: args)
        guard let json = cmdResult.result else {
            Log.log2File("json is nil", ["error" : cmdResult.errorMessage!])
            return nil
        }
        if json.isEmpty {
            
            Log.log2File("json is empty", ["error" : cmdResult.errorMessage!])
            return nil
        }
        return json
    }
    
    internal func download(with url: String, localPath: String, isProxyUrl: Bool = false) -> ytdlCommand.Handle {
        var args = [YOF.Output, localPath, url]
        if isProxyUrl {
            args.append(contentsOf: [YON.Proxy, Preference.proxy])
        }
        return ytdlCommand.command(args: args)
    }
    
    internal func update() {
        DispatchQueue.global().async {
            self.isUpdating = true
            
            let tmpUrl = PathUtility.cacheDirectoryURL.appendingPathComponent("youtube-dl");
            
            PathUtility.deleteFileIfExist(url: tmpUrl)

            let cmd = "wget https://yt-dl.org/latest/youtube-dl -O \(tmpUrl.path);chmod a+x \(tmpUrl.path);hash -r"

            _ = Shell.excuteCommand(cmd)
            
            if let ytdlPath = ytdlCommand.getYTDLPathFromSKDL() {
                
                let dst = URL(fileURLWithPath: ytdlPath, isDirectory: false) //URL(string: ytdlPath)
                
                print(dst)
                
                PathUtility.deleteFileIfExist(url: dst)
                PathUtility.moveFile(at: tmpUrl, to: dst)
                
            }
            
            self.isUpdating = false
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
    
    internal func register4UpdateStatus(_ key: String, _ handle: @escaping ytdlStatusChangedHandle) {
        statusChangedHandles[key] = handle
    }
    
    internal func removeUpdateStatus(_ key: String) {
        statusChangedHandles.removeValue(forKey: key)
    }
    
}
