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
}

fileprivate typealias C = Constant


class NTWindowController: NSWindowController {

    //MARK:- IBOutlet
    @IBOutlet var urlTextView: NSTextView!
    @IBOutlet weak var startDownloadButton: NSButton!
    
    
    //MARK:- life cycle
    override var windowNibName: String? {
        return "NTWindowController"
    }
    
    
    override func windowDidLoad() {
        super.windowDidLoad()

        setWindow()
        
    }
    
    //MARK:- file private
    
    fileprivate func setWindow() {
        window?.styleMask = [.borderless, .titled, .closable]
        window?.backingType = .buffered
        window?.title = C.windowTitle
        let frame = NSRect(x: 0, y: 0, width: C.windowDefaultWidth, height: C.windowDefaultHeight)
        window?.setFrame(frame, display: true)
        window?.maxSize = frame.size
        window?.minSize = frame.size
        window?.center()
    }
    
    //MARK:- button action
    
    @IBAction func startDownload(_ sender: Any) {
        
        let urls: [String]? = urlTextView.string?.components(separatedBy: "\n")
        
        print(urls)
        // 这里需要判断地址的有效性
        
        
    }
    
    

    
}
