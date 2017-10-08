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
        
        tableView.menu = menuForRightClick()
    }
    
    func menuForRightClick() -> NSMenu {
        let menu = NSMenu()
        menu.delegate = self
        return menu
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

extension MainDownloaderViewController: NSMenuDelegate {
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        menu.removeAllItems()
        // -1的时候表示没有选中行
        if tableView.clickedRow == -1 {
            return
        }
        let items = [startDownloadMenuItem(), suspendDownloadMenuItem(), removeDownloadMenuItem(), showInTheFinderMenuItem()]
        
        items.forEach { (item) in
            menu.addItem(item)
        }
    }
    
    func startDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "开始下载", action: #selector(self.startDownloadAction), keyEquivalent: "s")
    }
    
    @objc func startDownloadAction() {
        print(tableView.clickedRow)
        print("start download")
    }
    
    func suspendDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "暂停下载", action: #selector(self.suspendDownloadAction), keyEquivalent: "p")
    }
    
    @objc func suspendDownloadAction() {
         print(tableView.clickedRow)
        print("suspend download")
    }
    
    func removeDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "删除任务", action: #selector(self.removeDownloadAction), keyEquivalent: "d")
    }
    
    @objc func removeDownloadAction() {
         print(tableView.clickedRow)
        print("remove download")
    }
    
    func showInTheFinderMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "在Finder中显示", action: #selector(self.showInTheFinderAction), keyEquivalent: "f")
    }
    
    @objc func showInTheFinderAction() {
         print(tableView.clickedRow)
        print("show in the finder")
    }
    
}
