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
    
    weak var dManager = DownloadManager.manager
    
    //MARK:- life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        basicSetting()
        
    }
    
    func basicSetting() {
        setTableView()
        dManager?.registerStartHandle {
            self.tableView.reloadData()
        }
        dManager?.registerEndHandle {
            self.tableView.reloadData()
        }
    }
    
    func setTableView() {
        // 除去蓝色边框
        tableView.wantsLayer = true
        tableView.layer?.borderWidth = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

extension MainDownloaderViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (dManager?.unfinishedFiles.count)!
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = MainDownloadCellView(frame: NSRect.zero)
        cellView.addButton(target: self, selector: #selector(self.cellButtonClick))
        let file = dManager?.unfinishedFiles[row]
        cellView.file = file
        cellView.setButtonImage(state: (file?.state)!)
        cellView.nameLabel.stringValue = (file?.name)!
        cellView.sizeLabel.stringValue = (file?.sizeDescription)!
        if let task = file?.task {
            task.progressEvent = { ( progress ,speed , eta) in
                cellView.progressLabel.stringValue = progress
                cellView.speedLabel.stringValue = speed
                cellView.etaLabel.stringValue = eta
            }
        }
        return cellView
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 80
    }
    
    @objc func cellButtonClick(sender: NSButton) {
        let cellView = sender.superview as! MainDownloadCellView
        if cellView.file?.state == DLFile.State.downloading {
            cellView.file?.task?.suspend()
        } else {
            if cellView.file?.task == nil {
                dManager?.download(with: cellView.file!)
            } else {
                cellView.file?.task?.resume()
            }
        }
        cellView.setButtonImage(state: (cellView.file?.state)!)
    }

}
