//
//  NewDownloadTaskWindowController.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate let DefaultWindowWidth: Int = 450
fileprivate let DefaultWindowHeight: Int = 300

fileprivate let WindowTitle = "新建下载任务"

fileprivate let WarningTitle = "无效的链接"

fileprivate let WarningMessage = "下载链接无效"

class NewDownloadTaskWindowController: NSWindowController {

    //MARK:- IBOutlet
    @IBOutlet var urlTextView: NSTextView!
    
    @IBOutlet weak var analysisButton: NSButton!
    
    @IBOutlet weak var waitingView: NSVisualEffectView!
    
    @IBOutlet weak var waitingIdicator: NSProgressIndicator!
    
    //MARK:- var
    
    var detailWindowController: OnlineVideoDetailInfoWindowController?
    
    //MARK:- life cycle
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("NewDownloadTaskWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        setWindow()
        hideWaitingView()
        urlTextView.isRichText = false
        
    }
    
    //MARK:- file private
    

    
    fileprivate func setWindow() {
        window?.delegate = self
        window?.styleMask = [NSWindow.StyleMask.borderless, NSWindow.StyleMask.titled, NSWindow.StyleMask.closable]
        window?.backingType = .buffered
        window?.title = WindowTitle
        let frame = NSRect(x: 0, y: 0, width: DefaultWindowWidth, height: DefaultWindowHeight)
        window?.setFrame(frame, display: true)
        window?.maxSize = frame.size
        window?.minSize = frame.size
        window?.center()
    }
    
    fileprivate func showWaitingView() {
        self.waitingView.isHidden = false
        self.waitingIdicator.startAnimation(nil)
        self.urlTextView.isEditable = false
        self.analysisButton.isEnabled = false
    }
    
    fileprivate func hideWaitingView() {
        self.waitingView.isHidden = true
        self.waitingIdicator.stopAnimation(nil)
        self.urlTextView.isEditable = true
        self.analysisButton.isEnabled = true
    }

    //MARK:- button action
    
    @IBAction func analysisAction(_ sender: Any) {
        showWaitingView()
        let separatedStr = urlTextView.string.components(separatedBy: "\n")
        DispatchQueue.global().async {
            let urls = separatedStr.filter({ (str) -> Bool in
                if str == "" {
                    return false
                }
                return ytdlController.shared.isURLAvailable(url: str)
            })
            if (urls.isEmpty) {
                DispatchQueue.main.async {
                    self.hideWaitingView()
                    Alert.warn(WarningTitle, WarningMessage)
                }
                return
            }
        
            let jsons = ytdlController.shared.dumpJson(from: urls)
            
            var dumps: [[String : Any]] = []
            
            jsons?.forEach({ (json) in
                if json == "" {
                    return
                }
                let dump = JSONHelper.getDictionary(from: json)
                dumps.append(dump)
            })
            
            DispatchQueue.main.async {
                self.hideWaitingView()
                var videos: [Video] = []
                for (index,item) in urls.enumerated() {
                    let video = Video()
                    video.url = item
                    video.name = dumps[index][YDJKey.kTitle] as? String ?? ""
                    video.ext = dumps[index][YDJKey.kExt] as? String ?? ""
                    video.size = dumps[index][YDJKey.kFileSize] as? Int64 ?? 0
                    video.duration = dumps[index][YDJKey.kDuration] as? Int64 ?? 0
                    video.format = dumps[index][YDJKey.kFormat] as? String ?? ""
                    video.playlist = dumps[index][YDJKey.kPlayList] as? String ?? ""
                    video.id = dumps[index][YDJKey.kID] as? String ?? ""
                    videos.append(video)
                }
                self.detailWindowController = OnlineVideoDetailInfoWindowController(with: videos)
                self.detailWindowController?.showWindow(self)
            }

        }
    }
    
}

extension NewDownloadTaskWindowController: NSWindowDelegate {
 
    func windowWillClose(_ notification: Notification) {
        let appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.newTaskWindowController = nil
    }
    
}
