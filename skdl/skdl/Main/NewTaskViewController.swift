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
        
        newTaskView.okTitle = "Download"
    }

    override func okAction(_ sender: NSButton) {

        let url = newTaskView.url
        
        if url.isEmpty {
            print("url is empty")
            return
        }
        
        let useProxy = newTaskView.isUseProxy
        DispatchQueue.global().async {
           VideoDownloader.shared.download(with: url, useProxy)
        }
        super.okAction(sender)
    }
    
}
