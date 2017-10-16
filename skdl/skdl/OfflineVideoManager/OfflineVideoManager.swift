//
//  OfflineVideoManager.swift
//  skdl
//
//  Created by Skifary on 03/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal class OfflineVideoManager {
    
    //MARK:- property
    
    internal var offlineVideos: [Video] {
        return VideoManager.manager.offlineVideos
    }
    
    //MARK:- singleton

    internal static let manager = OfflineVideoManager()
    
    fileprivate init() {
        
    }
    
    //MARK:- api
    
    
}
