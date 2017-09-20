//
//  DownloadTask.swift
//  skdl
//
//  Created by Skifary on 11/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

typealias ProgressEvent = () -> Void



class DownloadTask {
    
    private var url: String?
    
    private var local: String?
    
    private var task: Process?
    
    private var out: Pipe?
    
    private var error: Pipe?
    
    private var progress: String?  //progress
    
    private var speed: String? // download speed
    
    private var eta: String? // Estimated Time of Arrival
    
    private var timer: Timer?
    
    
    private lazy var events: [ProgressEvent] = []
    
    //MARK:- life cycle
    
    convenience init(with url: String, local: String) {
        self.init()
        self.url = url
        self.local = local
    //    self.progressCallback = progressCallback
    }
    
    fileprivate init() {
        
    }
    
    deinit {
        
    }
    
    //MARK:- api
    
    func start() {
        let res = ytdlController.shared.download(url: self.url!, localPath: self.local!)
        self.error = res.error
        self.out = res.out
        self.task = res.task
        self.task?.launch()
        DownloadManager.manager.executingQueue.addOperation {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.readLoop), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
    }
    
     @objc fileprivate func readLoop() {
        
        let readingStr = String(data: (self.out?.fileHandleForReading.availableData)!, encoding: .utf8)
        
        let lastLine = readingStr?.components(separatedBy: "\n").last
        
        print("lastline ", lastLine)
        
        events.forEach { (event) in
            event()
        }
        
    }
    
    func appendEvent(event: @escaping ProgressEvent)  {
        events.append(event)
    }
    
    func stop() {
       //  thread?.cancel()
    }
    
    func pause() {
        //self.timer
        
    }
    

    
}
