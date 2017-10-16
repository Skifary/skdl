//
//  ytdlOptions.swift
//  skdl
//
//  Created by Skifary on 07/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal typealias YOS = ytdlOptions.Simulate
internal typealias YOF = ytdlOptions.Filesystem

internal struct ytdlOptions {
    
    internal struct Simulate {
        
        internal static let kGetUrl: String = "-g" //Simulate, quiet but print URL
        
        internal static let kDumpJson: String = "-j" //Simulate, quiet but print JSON information.
        
    }
    
    internal struct Filesystem {
        
       internal static let kOutput: String = "-o"  //Output filename template
        
    }
    
}
