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

//fileprivate let MaxConcurrentDownloadTaskCount = 5

internal typealias DownloadTaskStartHandle = () -> Void

internal typealias DownloadTaskEndHandle = () -> Void

//internal typealias

//MARK:- VideoDownloader
internal class VideoDownloader {

    //MARK:- property
    internal var downloadingVideos: [Video] {
        return VideoManager.manager.onlineVideos
    }
    
    internal var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = DownloadOperationQueueName
        queue.maxConcurrentOperationCount = 5
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
    
    internal func download(with url: String, _ useProxy: Bool = false) {
        
        var useProxy = useProxy
        
        // automate check proxy
        if useProxy == false {
            if let host = URL(string: url)?.host {
                // 判断 www.youtube.com
                if Config.shared.rules.contains(host) {
                    useProxy = true
                } else {
                    // 判断 youtube.com
                    var index = host.index(of: ".")!
                    index = host.index(after: index)
                    let subHost = host[index...]
                    useProxy = Config.shared.rules.contains(String(subHost))
                }
            }
        }

        guard let json = ytdlController.shared.dumpJson(url: url, useProxy) else {
            print("json is unavailable!")
            Log.log2File("can't dump json",["url" : url])
            return
        }
        
        guard let info = JSONHelper.getDictionary(from: json) else {
            print("can't get info from json")
            Log.log2File("can't get info from json",["json" : json])
            return
        }
        
        let video = Video()
        video.url = url
        video.name = info[YDJKey.kTitle] as? String ?? ""
        video.ext = info[YDJKey.kExt] as? String ?? ""
        video.size = info[YDJKey.kFileSize] as? Int64 ?? 0
        video.duration = info[YDJKey.kDuration] as? Int64 ?? 0
        video.format = info[YDJKey.kFormat] as? String ?? ""
        video.playlist = info[YDJKey.kPlayList] as? String ?? ""
        video.id = info[YDJKey.kID] as? String ?? ""

        video.localFolder = URL(string: "file://" + PV.localStoragePath!)

        video.needProxy = useProxy

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
        startHandles.append(handle)
    }
    
    internal func registerEndHandle(handle: @escaping DownloadTaskEndHandle) {
        endHandles.append(handle)
    }
    
}
