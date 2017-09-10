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
    @IBOutlet weak var analysisButton: NSButton!
    
    //MARK:- var
    
    var fiWindowController: FIWindowController?
    
    //MARK:- life cycle
    override var windowNibName: String? {
        return "NTWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        setWindow()
        
        self.urlTextView.delegate = self
        
    }
    
    //MARK:- file private
    
    fileprivate func setWindow() {
        self.window?.delegate = self
        window?.styleMask = [.borderless, .titled, .closable]
        window?.backingType = .buffered
        window?.title = C.windowTitle
        let frame = NSRect(x: 0, y: 0, width: C.windowDefaultWidth, height: C.windowDefaultHeight)
        window?.setFrame(frame, display: true)
        window?.maxSize = frame.size
        window?.minSize = frame.size
        window?.center()
    }
    
//    fileprivate func setText
    
    //MARK:- button action
    
    @IBAction func analysisAction(_ sender: Any) {
        
        let urls: [String]? = urlTextView.string?.components(separatedBy: "\n")
        
         /* TODO: 这里需要放到其他线程，显示菊花 */
        let jsons = ytdlController.shared.dumpJson(urls: urls!)
        let dics = JSONHelper.convertJSONToDictionary(jsons: jsons!)
        var files: [DLFile] = []
        
        if (dics?.isEmpty)! {
            /* TODO: 弹窗错误
             */
            // 这里需要加弹窗错误
            return
        }
        
        for (index,item) in (urls?.enumerated())! {
            let file = DLFile()
            file.url = item
            file.name = dics?[index]["title"] as? String
            file.ext = dics?[index]["ext"] as? String
            file.size = dics?[index]["filesize"] as? uint64
            file.duration = dics?[index]["duration"] as? uint64
            file.format = dics?[index]["format"] as? String
            file.playlist = dics?[index]["playlist"] as? String
            files.append(file)
        }
        
        fiWindowController = FIWindowController(files: files)
        
        fiWindowController?.showWindow(self)
        
    }
    
}


extension NTWindowController: NSWindowDelegate {
 
    func windowWillClose(_ notification: Notification) {
        let appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.newTaskWindowController = nil
    }
    
}

/* TODO: 这里需要去除富文本
 */

extension NTWindowController: NSTextViewDelegate {
    
    func textDidChange(_ notification: Notification) {
        print("text did change")
        
   //    urlTextView.textStorage?.attributeKeys.forEach { (key) in
     //       urlTextView.textStorage?.removeAttribute(key, range: NSRange.init(location: 0, length: urlTextView.attributedString().length))
      //  }
      //  return
//     //   urlTextView.textStorage?.removeAttribute(NSBackgroundColorAttributeName, range: <#T##NSRange#>)
//        
//        self.urlTextView.string = "123"
//        
//        let a = self.urlTextView.attributedString().attributeKeys
//        _=1
//       // self.urlTextView.attributedString().
    }
    
    
    
}
