//
//  ytdlOptions.swift
//  skdl
//
//  Created by Skifary on 07/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


typealias YOS = ytdlOptions.Simulate
typealias YOF = ytdlOptions.Filesystem

struct ytdlOptions {
    
    struct Simulate {
        
        static let kGetUrl: String = "-g" //Simulate, quiet but print URL
        
        static let kDumpJson: String = "-j" //Simulate, quiet but print JSON information.
        
        
    }
    
    struct Filesystem {
        
        static let kOutput: String = "-o"  //Output filename template
        
    }
    
}
