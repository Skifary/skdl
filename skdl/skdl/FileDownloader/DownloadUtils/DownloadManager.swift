//
//  DownloadManager.swift
//  skdl
//
//  Created by Skifary on 11/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

fileprivate let operationQueueName = "com.skifary.skdl.download"
fileprivate let maxConcurrentOperationCount = 5

typealias StartHandle = () -> Void
typealias EndHandle = () -> Void


class DownloadManager {
    
    //MARK:- property
    
    var unfinishedFiles: [DLFile] {
        get {
           return DLFileManager.manager.unfinishedFiles
        }
    }
    
    var executingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = operationQueueName
        queue.maxConcurrentOperationCount = maxConcurrentOperationCount
        return queue
    }()
    
    fileprivate var startHandles = [StartHandle]()
    
    fileprivate var endHandles = [EndHandle]()
    
    //MARK:- singleton
    
    static let manager = DownloadManager()
    
    fileprivate init() {
        
    }
    
    //MARK:- api
    
    func download(with file: DLFile) {
        let downloadTask = DownloadTask(with: file)
        file.task = downloadTask
        file.state = .downloading
        DLFileManager.manager.add(file)
        downloadTask.start()
        startHandles.forEach { (handle) in
            handle()
        }
    }
    
    func taskFinish(task: DownloadTask) {
        let file = task.file!
        file.state = .completed
        DispatchQueue.main.async {
            PathUtility.renameFileIfExist(old: file.tmpFilePath, new: file.filePath)
            self.endHandles.forEach { (handle) in
                handle()
            }
        }
    }
    
    func remove(file: DLFile) {
        let task = file.task
        
        task?.stop()
        
        DLFileManager.manager.remove(file)
        
    }
    
    func registerStartHandle(handle: @escaping StartHandle) {
        self.startHandles.append(handle)
    }
    
    func registerEndHandle(handle: @escaping EndHandle) {
        self.endHandles.append(handle)
    }
    
}
