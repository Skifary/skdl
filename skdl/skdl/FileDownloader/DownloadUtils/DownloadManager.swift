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

class DownloadManager {
    
    //MARK:- property
    
    var executingTask: SKQueue<DownloadTask>? = SKQueue<DownloadTask>()
    
    var waitingTask: SKQueue<DownloadTask>? ///????待定 先不考虑
    
    var executingQueue: OperationQueue
    
    //MARK:- singleton
    
    static let manager = DownloadManager()
    
    fileprivate init() {
        executingQueue = OperationQueue()
        executingQueue.name = operationQueueName
        executingQueue.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
    
    //MARK:- api
    
    
//    func download(with url: String, local: String, progressCallback: @escaping ProgressCallbackFunc) {
//        let downloadTask = DownloadTask(with: url, local: local, progressCallback: progressCallback)
//        self.executingTask?.push(element: downloadTask)
//        downloadTask.start()
//    }

    func download(with file: DLFile) {
        let downloadTask = DownloadTask(with: file.url!, local: file.local!)
        self.executingTask?.push(element: downloadTask)
        downloadTask.start()
    }
    
//    func download(with urls: [String], locals: String, progressCallbacks: [ProgressCallbackFunc]) {
//        urls.forEach { (url) in
//            downloadWith(url: url)
//        }
        
        
 //   }
    
}
