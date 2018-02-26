//
//  Log.swift
//  skdl
//
//  Created by Skifary on 12/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


public class Log {
    
//    public static func debugLog<T>(_ message: T) {
//        #if DEBUG
//            print("debug log : \(#file) \(#function) \(#line) \n \(message)")
//        #endif
//    }
    
//    public static func log<T>(_ message: T) {
//        #if DEBUG
//            print("log: \(message)")
//        #endif
//    }
    
//    public static func logWithCallStack<T>(_ message: T) {
//        #if DEBUG
//            print("log: \(message)")
//            print(Thread.callStackSymbols.joined(separator: "\n"))
//        #endif
//    }
    
    /* TODO: 需要做一个简单的日志文件系统 */
 
    static public func log2File(_ content: String, _ param: [String : String] = [:]) {
        LogManager.shared.log2File(content, param)

    }
    
    
}

public class LogManager {
    
    static let shared = LogManager()
    
    lazy var logDir: URL = {
        let path = PathUtility.appSupportDirectoryURL.path + "/log"
        let url = URL(string: path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
        PathUtility.createDirectoryIfNotExist(url: url)
        return url
    }()
    
//    var currentZoneDate: Date {
//        var date = Date()
//        let timezone = NSTimeZone.system
//        let interval = timezone.secondsFromGMT()
//        date = date.addingTimeInterval(Double(interval))
//        return date
//    }
    
    var currentDateComponents: DateComponents {
        return Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: Date())
    }
    
    var logPath: URL {
        var path = logDir.path
        let comp = currentDateComponents
        path = "\(path)/\(String(format: "%04d", comp.year!))_\(String(format: "%02d", comp.month!))_\(String(format: "%02d", comp.day!)).log"
        return URL(string: path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
    }
    
    func log2File(_ content: String, _ param: [String : String]) {
        
        let msg = message(content, param)
        write(msg, logPath.path)

    }
    
    func message(_ content: String, _ param: [String : String]) -> String {
        
        var msg: String
        
        // date/time
        let comp = currentDateComponents
        msg = "Date/time: \(String(format: "%04d", comp.year!))-\(String(format: "%02d", comp.month!))-\(String(format: "%02d", comp.day!)) \(String(format: "%02d", comp.hour!)):\(String(format: "%02d", comp.minute!)):\(String(format: "%02d", comp.second!))"
        msg += "\n"
        
        // param
        param.forEach { (key, value) in
            msg += "\(key): \(value)\n"
        }
        
        //content
        msg += "Message: \(content)\n"
        msg += "\n"
        return msg
    }
    
    func write(_ message: String, _ path: String) {
    
        if !FileManager.default.fileExists(atPath: path) {
            FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        }
        
        let handle: FileHandle
        
        do {
            try handle = FileHandle(forUpdating: URL(string: path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!)
        } catch {
            print("can't open file in \(path)")
            print(error.localizedDescription)
            return
        }
        
        handle.seekToEndOfFile()
        handle.write(message.data(using: .utf8)!)
        handle.closeFile()
    }
    
}
