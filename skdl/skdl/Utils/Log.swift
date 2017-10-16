//
//  Log.swift
//  skdl
//
//  Created by Skifary on 12/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


public class Log {
    
    public static func debugLog<T>(_ message: T) {
        #if DEBUG
            print("debug log : \(#file) \(#function) \(#line) \n \(message)")
        #endif
    }
    
    public static func log<T>(_ message: T) {
        #if DEBUG
            print("log: \(message)")
        #endif
    }
    
    public static func logWithCallStack<T>(_ message: T) {
        #if DEBUG
            print("log: \(message)")
            print(Thread.callStackSymbols.joined(separator: "\n"))
        #endif
    }
    
}
