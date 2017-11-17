//
//  OnlineVideoDownloader.swift
//  skdl
//
//  Created by Skifary on 11/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

//MARK:- fileprivate constante
fileprivate let DownloadOperationQueueName = "com.skifary.skdl.downloadqueue"

fileprivate let MaxConcurrentDownloadTaskCount = 5

internal typealias DownloadTaskStartHandle = () -> Void

internal typealias DownloadTaskEndHandle = () -> Void

//MARK:- VideoDownloader
internal class VideoDownloader {

    //MARK:- property
    internal var downloadingVideos: [Video] {
        return VideoManager.manager.onlineVideos
    }
    
    internal var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = DownloadOperationQueueName
        queue.maxConcurrentOperationCount = MaxConcurrentDownloadTaskCount
        return queue
    }()
    
    fileprivate var startHandles: [DownloadTaskStartHandle] = []
    
    fileprivate var endHandles: [DownloadTaskEndHandle] = []
    
    //MARK:- singleton
    
    internal static let shared = VideoDownloader()
    
    fileprivate init() {
    }
    
    //MARK:- api
    
    internal func download(with video: Video) {
        let task = DownloadTask(with: video)
        video.task = task
        video.state = .downloading
        VideoManager.manager.add(video)
        task.start()
        DispatchQueue.main.async {
            self.startHandles.forEach { (handle) in
                handle()
            }
        }
    }
    
    internal func download(with url: String) {
        guard url != "" else {
            let error = "url is nil!"
            Log.log(error)
            return
        }
        
        print("download")
        var isPorxyUrl = false
        
        if !ytdlController.shared.isURLAvailable(url: url) {
            if !ytdlController.shared.isURLAvailableInProxy(url: url) {
                let error = "url is unavailable!"
                Log.log(error)
                return
            }
            isPorxyUrl = true
        }
        print("dump json start")
        guard let json = ytdlController.shared.dumpJson(url: url, isPorxyUrl) else {
            let error = "json is unavailable!"
            Log.log(error)
            return
        }
        
        let dump = JSONHelper.getDictionary(from: json)
        
        let video = Video()
        video.url = url
        video.name = dump[YDJKey.kTitle] as? String ?? ""
        video.ext = dump[YDJKey.kExt] as? String ?? ""
        video.size = dump[YDJKey.kFileSize] as? Int64 ?? 0
        video.duration = dump[YDJKey.kDuration] as? Int64 ?? 0
        video.format = dump[YDJKey.kFormat] as? String ?? ""
        video.playlist = dump[YDJKey.kPlayList] as? String ?? ""
        video.id = dump[YDJKey.kID] as? String ?? ""
        
        video.localFolder = URL(string: "file://" + PV.localStoragePath!)
        
        video.needProxy = isPorxyUrl
        
        print("download start")
        download(with: video)
        
    }
    
    internal func finish(task: DownloadTask) {
        let video = task.video!
        video.state = .offline
        DispatchQueue.main.async {
            PathUtility.renameFileIfExist(old: video.downloadPath!, new: video.filePath!)
            self.endHandles.forEach { (handle) in
                handle()
            }
        }
    }
    
    internal func remove(video: Video) {
        let task = video.task
        task?.stop()
        VideoManager.manager.remove(video)
    }
    
    internal func registerStartHandle(handle: @escaping DownloadTaskStartHandle) {
        self.startHandles.append(handle)
    }
    
    internal func registerEndHandle(handle: @escaping DownloadTaskEndHandle) {
        self.endHandles.append(handle)
    }
    
}
