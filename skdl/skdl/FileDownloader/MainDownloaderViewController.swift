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
          //  cellView.file?.task?.suspend()
            suspendDownload(file: cellView.file!)
        } else {
//            if cellView.file?.task == nil {
//                dManager?.download(with: cellView.file!)
//            } else {
//                cellView.file?.task?.resume()
//            }
            
            startDownload(file: cellView.file!)
            
        }
        cellView.setButtonImage(state: (cellView.file?.state)!)
    }
    
    func suspendDownload(file: DLFile) {
        file.task?.suspend()
    }
    
    func startDownload(file: DLFile) {
        if file.task == nil {
            dManager?.download(with: file)
        } else {
            file.task?.resume()
        }
    }
}

extension MainDownloaderViewController: NSMenuDelegate {
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        menu.removeAllItems()
        
        let row = tableView.clickedRow
        // -1的时候表示没有选中行
        if row  == -1 {
            return
        }
        let file = dManager?.unfinishedFiles[row]
        let item = file?.state == DLFile.State.downloading ? suspendDownloadMenuItem() : startDownloadMenuItem()
        let items = [item , removeDownloadMenuItem(), showInTheFinderMenuItem()]
        items.forEach { (item) in
            menu.addItem(item)
        }
    }
    
    func startDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "开始下载", action: #selector(self.startDownloadAction), keyEquivalent: "s")
    }
    
    @objc func startDownloadAction() {

        let row = tableView.clickedRow
        let cellView = tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! MainDownloadCellView
        let file = dManager?.unfinishedFiles[row]
        
        startDownload(file: file!)
        
        cellView.setButtonImage(state: (file?.state)!)
        
        print("start download")
    }
    
    func suspendDownloadMenuItem() -> NSMenuItem {
        
      
        
        
        return NSMenuItem(title: "暂停下载", action: #selector(self.suspendDownloadAction), keyEquivalent: "p")
    }
    
    @objc func suspendDownloadAction() {
        
        let row = tableView.clickedRow
        let cellView = tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! MainDownloadCellView
        let file = dManager?.unfinishedFiles[row]
        
        suspendDownload(file: file!)
        
        cellView.setButtonImage(state: (file?.state)!)
        
        print("suspend download")
    }
    
    func removeDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "删除任务", action: #selector(self.removeDownloadAction), keyEquivalent: "d")
    }
    
    @objc func removeDownloadAction() {
        
        let row = tableView.clickedRow
        
        let file = dManager?.unfinishedFiles[row]
        
        dManager?.remove(file: file!)
        
        tableView.reloadData()
        print("remove download")
    }
    
    func showInTheFinderMenuItem() -> NSMenuItem {
        
    
        return NSMenuItem(title: "在Finder中显示", action: #selector(self.showInTheFinderAction), keyEquivalent: "f")
    }
    
    @objc func showInTheFinderAction() {
        
        
        let row = tableView.clickedRow
        
        let file = dManager?.unfinishedFiles[row]
        
        NSWorkspace.shared.selectFile((file?.tmpFilePath.path)!+".part", inFileViewerRootedAtPath: (file?.localFolder?.path)!)
        

        
        print("show in the finder")
    }
    
}
