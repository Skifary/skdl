//
//  DLFile.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class DLFile: NSObject {
    
    enum State {
        case downloading
        case uncompleted
        case completed
    }
    
    var url: String? = ""
    
    var name: String? = ""
    
    var size: uint64? = 0
    
    var duration: uint64? = 0
    
    var format: String? = ""
    
    var ext: String? = ""
    
    var playlist: String? = ""
    
    var local: String? = ""
    
    var progress: String = "0.0%"
    
   // var isComplete: Bool = false
    var state: State = .uncompleted
    
    var task: DownloadTask?
    
    var sizeDescription: String {
        get {
           return FileSize.format(size: size)
        }
    }
    
}
