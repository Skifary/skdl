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
    
    var unfinishedFiles = [DLFile]()
    
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
        self.unfinishedFiles.append(file)
        downloadTask.start()
        startHandles.forEach { (handle) in
            handle()
        }
    }
    
    func addFile(file: DLFile) {
        self.unfinishedFiles.append(file)
    }
    
    func taskFinish(task: DownloadTask) {
        task.file?.state = .completed
        self.unfinishedFiles.remove(at: self.unfinishedFiles.index(of: task.file!)!)
        let dlFileManager = DLFileManager.manager
        dlFileManager.appendFinishedFile(file: task.file!)
        self.endHandles.forEach { (handle) in
            DispatchQueue.main.async {
                handle()
            }
        }
    }
    
    func registerStartHandle(handle: @escaping StartHandle) {
        self.startHandles.append(handle)
    }
    
    func registerEndHandle(handle: @escaping EndHandle) {
        self.endHandles.append(handle)
    }
    
}
