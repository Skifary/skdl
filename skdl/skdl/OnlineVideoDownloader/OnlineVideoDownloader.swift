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

//MARK:- OnlineVideoDownloader
internal class OnlineVideoDownloader {

    //MARK:- property
    internal var onlineVideos: [Video] {
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
    
    internal static let shared = OnlineVideoDownloader()
    
    fileprivate init() {
    }
    
    //MARK:- api
    
    internal func download(with video: Video) {
        let task = OnlineDownloadTask(with: video)
        video.task = task
        video.state = .downloading
        VideoManager.manager.add(video)
        task.start()
        startHandles.forEach { (handle) in
            handle()
        }
    }
    
    internal func finish(task: OnlineDownloadTask) {
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
