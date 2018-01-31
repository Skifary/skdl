//
//  NewTaskViewController.swift
//  skdl
//
//  Created by Skifary on 26/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class NewTaskViewController: BasicViewController {

    
    //MARK:-
    
    var newTaskView: NewTaskView {
        return view as! NewTaskView
    }
    
    //MARK:-
    
    override func loadView() {
        view = NewTaskView(frame: NSRect.zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newTaskView.okTitle = "DOWNLOAD"
    }
    
    override func okAction(_ sender: NSButton) {
        let url = newTaskView.url
        let isUseProxy = newTaskView.isUseProxy
        DispatchQueue.global().async {
            self.download(with: url, isUseProxy)
        }
        super.okAction(sender)
    }
    
    //MARK:-
    
    func download(with url: String, _ isUseProxy: Bool = false) {
        
        guard url != "" else {
            let error = "url is nil!"
            Log.log(error)
          //  showError(error)
            return
        }

        // 需要理清逻辑，例如需要proxy和不需要proxy，应该根据网址来判断
        // 给一个需要自动判断和添加的地方？
        
        guard let json = ytdlController.shared.dumpJson(url: url, isUseProxy) else {
            let error = "json is unavailable!"
            Log.log(error)
            //showError(error)
            return
        }
        
        let dump = JSONHelper.getDictionary(from: json)
        
        let video = Video()
        video.url = url
        video.name = dump[YDJKey.kTitle] as? String ?? ""
        video.ext = dump[YDJKey.kExt] as? String ?? ""
        video.size = dump[YDJKey.kFileSize] as? Int64 ?? 0
        video.duration = dump[YDJKey.kDuration] as? Int64 ?? 0
        video.format = dump[YDJKey.kFormat] as? String ?? ""
        video.playlist = dump[YDJKey.kPlayList] as? String ?? ""
        video.id = dump[YDJKey.kID] as? String ?? ""
        
        video.localFolder = URL(string: "file://" + PV.localStoragePath!)
        
        video.needProxy = isUseProxy
        VideoDownloader.shared.download(with: video)
    }
  
}
