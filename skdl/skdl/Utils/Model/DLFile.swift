//
//  DLFile.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class DLFile: NSObject {
    
    var url: String? = ""
    
    var name: String? = ""
    
    var size: uint64? = 0
    
    var duration: uint64? = 0
    
    var format: String? = ""
    
    var ext: String? = ""
    
    var playlist: String? = ""
    
    var sizeDescription: String {
        get {
           return FileSize.format(size: size!)
        }
    }
    
}
