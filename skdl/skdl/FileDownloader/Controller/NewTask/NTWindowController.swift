//
//  NTWindowController.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate struct Constant {
    
    static let windowDefaultWidth: Int = 450
    static let windowDefaultHeight: Int = 300
    
    static let windowTitle = "新建下载任务"
    
    static let warningTitle = "无效的链接"
    
    static let warningMessage = "下载链接无效"
    
}

fileprivate typealias C = Constant


class NTWindowController: NSWindowController {

    //MARK:- IBOutlet
    @IBOutlet var urlTextView: NSTextView!
    
    @IBOutlet weak var analysisButton: NSButton!
    
    @IBOutlet weak var waitingView: NSVisualEffectView!
    
    @IBOutlet weak var waitingIdicator: NSProgressIndicator!
    
    //MARK:- var
    
    var fiWindowController: FIWindowController?
    
    //MARK:- life cycle
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("NTWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        basicSetting()
        
    }
    
    //MARK:- file private
    
    fileprivate func basicSetting() {
        setWindow()
        hideWaitingView()
        urlTextView.isRichText = false
    }
    
    fileprivate func setWindow() {
        self.window?.delegate = self
        window?.styleMask = [NSWindow.StyleMask.borderless, NSWindow.StyleMask.titled, NSWindow.StyleMask.closable]
        window?.backingType = .buffered
        window?.title = C.windowTitle
        let frame = NSRect(x: 0, y: 0, width: C.windowDefaultWidth, height: C.windowDefaultHeight)
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
                return ytdlController.shared.isUrlAvailable(url: str)
            })
            if (urls.isEmpty) {
                DispatchQueue.main.async {
                    self.hideWaitingView()
                    MessageAlert.show(title: C.warningTitle, message: C.warningMessage)
                }
                return
            }
        
            let jsons = ytdlController.shared.dumpJson(urls: urls)
            let dics = JSONHelper.convertJSONToDictionary(jsons: jsons!)
            
            DispatchQueue.main.async {
                self.hideWaitingView()
                var files: [DLFile] = []
                for (index,item) in urls.enumerated() {
                    let file = DLFile()
                    file.url = item
                    file.name = dics?[index][YDJKey.kTitle] as? String
                    file.ext = dics?[index][YDJKey.kExt] as? String
                    file.size = dics?[index][YDJKey.kFileSize] as? uint64
                    file.duration = dics?[index][YDJKey.kDuration] as? uint64
                    file.format = dics?[index][YDJKey.kFormat] as? String
                    file.playlist = dics?[index][YDJKey.kPlayList] as? String
                    files.append(file)
                }
                self.fiWindowController = FIWindowController(files: files)
                self.fiWindowController?.showWindow(self)
            }

        }
    }
    
}

extension NTWindowController: NSWindowDelegate {
 
    func windowWillClose(_ notification: Notification) {
        let appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.newTaskWindowController = nil
    }
    
}
