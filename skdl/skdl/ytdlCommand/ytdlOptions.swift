//
//  ytdlOptions.swift
//  skdl
//
//  Created by Skifary on 07/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal typealias YO = ytdlOptions
internal typealias YOS = ytdlOptions.Simulate
internal typealias YOF = ytdlOptions.Filesystem
internal typealias YON = ytdlOptions.NetworkOptions

internal struct ytdlOptions {
    
    static let Update: String = "-U" // update to latest version
    
    static let Version: String = "--version" // youtube-dl version
    
    internal struct Simulate {
        
        static let GetUrl: String = "-g" //Simulate, quiet but print URL
        
        static let DumpJson: String = "-j" //Simulate, quiet but print JSON information.
        
    }
    
    internal struct Filesystem {
        
        static let Output: String = "-o"  //Output filename template
        
    }
    
    internal struct NetworkOptions {
        
        static let Proxy: String = "--proxy" // 代理协议
        // 由此考虑 是不是做一个超时重试时间？
        static let SocketTimeout: String = "--socket-timeout" //设置默认超时时间
    }
    
}
