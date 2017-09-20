//
//  MainDownloaderViewController.swift
//  skdl
//
//  Created by Skifary on 14/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class MainDownloaderViewController: NSViewController {
    
    
    //MARK:- IBOutlet

    @IBOutlet weak var tableView: NSTableView!
    
    
    //MARK:- var 
    
    var dManager = DownloadManager.manager
    
    //MARK:- life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        basicSetting()
        

        
    }
    
    
    func basicSetting() {
        setTableView()
    }
    
    func setTableView() {
        // 除去蓝色边框
        tableView.wantsLayer = true
        tableView.layer?.borderWidth = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.make(withIdentifier: "com.dele", owner: self)
    }
    
}

extension MainDownloaderViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cellView = MainDownloadCellView(frame: NSRect.zero)
        
        return cellView

    }
    
    

}
