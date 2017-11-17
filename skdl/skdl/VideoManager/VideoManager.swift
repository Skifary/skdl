//
//  VideoManager.swift
//  skdl
//
//  Created by Skifary on 03/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal class VideoManager {
    
    //MARK:- property
    
    fileprivate var videos: [Video]
    
    internal var onlineVideos: [Video] {
        return videos.filter { (v) -> Bool in
            return v.state == Video.State.online || v.state == Video.State.downloading
        }
    }
    
    internal var offlineVideos: [Video] {
        return videos.filter { (v) -> Bool in
            return v.state == Video.State.offline
        }
    }
    
    fileprivate let historyUrl = PathUtility.appSupportDirectoryURL.appendingPathComponent(AppData.HistoryFileName, isDirectory: false)
    
    //MARK:- singleton
    
    internal static let manager = VideoManager()
    
    fileprivate init() {
        videos = (NSKeyedUnarchiver.unarchiveObject(withFile: historyUrl.path) as? [Video]) ?? []
    }
    
    //MARK:- api
    
    internal func save() {
        PathUtility.deleteFileIfExist(url: historyUrl)
        if !NSKeyedArchiver.archiveRootObject(videos, toFile: historyUrl.path) {
            Log.log("Cannot save files history!")
        }
    }
    
    internal func add(_ video: Video) {
        if !videos.contains(video) {
            videos.append(video)
        }
    }
    
    internal func remove(_ video: Video) {
        videos = videos.filter { $0 != video }
    }
    
    internal func quitAndSave() {
        onlineVideos.forEach { (v) in
            v.task?.interrupt()
            v.state = Video.State.online
        }
        save()
    }
    
}
