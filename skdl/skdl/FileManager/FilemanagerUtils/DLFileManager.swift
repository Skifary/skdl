//
//  DLFileManager.swift
//  skdl
//
//  Created by Skifary on 25/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


class DLFileManager {
    
    //MARK:- property
    
    var finishedFiles = [DLFile]()
    
    //MARK:- singleton
    
    static let manager = DLFileManager()
    
    fileprivate init() {
    }
    
    //MARK:- api
    
    func appendFinishedFile(file: DLFile) {
        finishedFiles.append(file)
    }
}
