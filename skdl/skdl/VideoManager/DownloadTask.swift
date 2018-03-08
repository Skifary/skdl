//
//  OnlineDownloadTask.swift
//  skdl
//
//  Created by Skifary on 11/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

internal typealias ProgressEvent = (_ progress: String,_ speed: String,_ eta: String) -> Void

internal class DownloadTask: NSObject {
    
    //MARK:- property
    
    internal weak var video: Video!
    
    internal var progressEvent: ProgressEvent?

    private var url: String {
        return video.url
    }
    
    private var local: String? {
        return video.downloadPath?.path
    }
    
    private var process: Process!
    
    private var out: Pipe!
    
    private var error: Pipe!
    
    private var progress: String?  //progress
    
    private var speed: String? // download speed
    
    private var eta: String? // Estimated Time of Arrival
    
    private var timer: Timer?
    
    //MARK:- life cycle
    
    internal convenience init(with video: Video) {
        self.init()
        self.video = video
    }
    
    override init() {
        
    }
    
    //MARK:- api
    
    internal func start() {
        let handle = ytdlController.shared.download(with: url, localPath: local!, isProxyUrl: video.needProxy)
        error = handle.error
        out = handle.out
        process = handle.process
        process.launch()
        VideoDownloader.shared.downloadQueue.addOperation {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.readLoop), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
    }
    
     @objc fileprivate func readLoop() {
        
        if process.isRunning == false {
            finish()
        }
        
        let readingStr = String(data: out.fileHandleForReading.availableData, encoding: .utf8)
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

    internal func interrupt() {
        process.interrupt()
    }
    
    internal func suspend() {
        video.state = .online
        process.suspend()
    }
    
    internal func resume() {
        video.state = .downloading
        process.resume()
    }

    internal func finish() {
        VideoDownloader.shared.finish(task: self)
        timer?.invalidate()
        timer = nil
    }
    
    internal func stop() {
        self.timer?.invalidate()
        self.timer = nil
        interrupt()
    }
    
}
