//
//  DownloadTask.swift
//  skdl
//
//  Created by Skifary on 11/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

typealias ProgressEvent = (_ progress: String,_ speed: String,_ eta: String) -> Void



class DownloadTask: NSObject {
    
    //MARK:- property
    
    weak var file: DLFile?
    
    var progressEvent: ProgressEvent?

    private var url: String? {
        get {
            return file?.url
        }
    }
    
    private var local: String? {
        get {
            return file?.tmpFilePath.path
        }
    }
    
    private var task: Process?
    
    private var out: Pipe?
    
    private var error: Pipe?
    
    private var progress: String?  //progress
    
    private var speed: String? // download speed
    
    private var eta: String? // Estimated Time of Arrival
    
    private var timer: Timer?
    
   // private lazy var events: [ProgressEvent] = []
    
    //MARK:- life cycle
    
    convenience init(with file: DLFile) {
        self.init()
        self.file = file
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
            
            print("start")
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.readLoop), userInfo: nil, repeats: true)
        //    RunLoop.current.add(self.timer!, forMode: RunLoopMode.defaultRunLoopMode)
            RunLoop.current.run()
            
            print("stop")
            
        }
    }
    
     @objc fileprivate func readLoop() {
        
        if self.task?.isRunning == false {
            finish()
        }
        
        let readingStr = String(data: (self.out?.fileHandleForReading.availableData)!, encoding: .utf8)
        let lastLine = readingStr?.components(separatedBy: "[download]").last
        let ret = lastLine?.components(separatedBy: " ").filter({ (str) -> Bool in
            if str == "" {
                return false
            }
            return true
        })
        
        // 有点硬
        if ret?.count == 7 {
            let progress = ret![0]
            let speed = ret![4]
            let eta = ret![6]
            DispatchQueue.main.async {
                self.progressEvent?(progress ,speed ,eta)
            }
        }
        
    }

    func interrupt() {
        self.task?.interrupt()
    }
    
    func suspend() {
        file?.state = .uncompleted
        self.task?.suspend()
    }
    
    func resume() {
        file?.state = .downloading
        self.task?.resume()
    }

    func finish() {
        let manager = DownloadManager.manager
        manager.taskFinish(task: self)
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
        
        interrupt()
        
    }
    
}
