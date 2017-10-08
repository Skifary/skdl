//
//  LocalManager.swift
//  skdl
//
//  Created by Skifary on 03/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


class LocalManager {
    
    //MARK:- property
    
    var localFiles: [DLFile] {
        get {
            return DLFileManager.manager.finishedFiles
        }
    }
    
    //MARK:- singleton

    static let manager = LocalManager()
    
    fileprivate init() {
        
    }
    
    //MARK:- api
    
    
}
