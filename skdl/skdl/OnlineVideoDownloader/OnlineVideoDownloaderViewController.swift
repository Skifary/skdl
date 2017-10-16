//
//  OnlineVideoDownloaderViewController.swift
//  skdl
//
//  Created by Skifary on 14/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class OnlineVideoDownloaderViewController: NSViewController {
    
    struct Identifier {
       static let OnlineVideoDownloaderCell = "OnlineVideoDownloaderCell"
    }
    
    //MARK:- IBOutlet

    @IBOutlet weak var tableView: NSTableView!
    
    //MARK:- var 
    
    weak var downloader: OnlineVideoDownloader! = OnlineVideoDownloader.shared
    
    //MARK:- life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
        downloader.registerStartHandle {
            self.tableView.reloadData()
        }
        downloader.registerEndHandle {
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

extension OnlineVideoDownloaderViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return downloader.onlineVideos.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = MainDownloadCellView(frame: NSRect.zero)
        cell.addButton(target: self, selector: #selector(self.cellButtonClick))
        let video = downloader.onlineVideos[row]
        cell.video = video
        cell.setButtonImage(state: video.state)
        cell.nameLabel.stringValue = video.name
        cell.sizeLabel.stringValue = video.sizeDescription
        if let task = video.task {
            task.progressEvent = { ( progress ,speed , eta) in
                cell.progressLabel.stringValue = progress
                cell.speedLabel.stringValue = speed
                cell.etaLabel.stringValue = eta
            }
        }
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 80
    }
    
    @objc fileprivate func cellButtonClick(sender: NSButton) {
        let cell = sender.superview as! MainDownloadCellView
        if cell.video.state == Video.State.downloading {
            suspendDownload(cell.video)
        } else {
            startDownload(cell.video)
        }
        cell.setButtonImage(state: cell.video.state)
    }
    
    func suspendDownload(_ video: Video) {
        video.task?.suspend()
    }
    
    func startDownload(_ video: Video) {
        guard let task = video.task else {
            downloader.download(with: video)
            return
        }
        task.resume()
    }
}

extension OnlineVideoDownloaderViewController: NSMenuDelegate {
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        menu.removeAllItems()
        
        let row = tableView.clickedRow
        // -1的时候表示没有选中行
        if row  == -1 {
            return
        }
        let video = downloader.onlineVideos[row]
        let item = video.state == Video.State.downloading ? suspendDownloadMenuItem() : startDownloadMenuItem()
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
        let cell = tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! MainDownloadCellView
        let video = downloader.onlineVideos[row]
        startDownload(video)
        cell.setButtonImage(state: video.state)
    }
    
    func suspendDownloadMenuItem() -> NSMenuItem {
        
        return NSMenuItem(title: "暂停下载", action: #selector(self.suspendDownloadAction), keyEquivalent: "p")
    }
    
    @objc func suspendDownloadAction() {
        
        let row = tableView.clickedRow
        let cell = tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! MainDownloadCellView
        let video = downloader.onlineVideos[row]
        
        suspendDownload(video)
        
        cell.setButtonImage(state: video.state)
        
    }
    
    func removeDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "删除任务", action: #selector(self.removeDownloadAction), keyEquivalent: "d")
    }
    
    @objc func removeDownloadAction() {
        
        let row = tableView.clickedRow
        
        let video = downloader.onlineVideos[row]
        
        downloader.remove(video: video)
        
        tableView.reloadData()
        
    }
    
    func showInTheFinderMenuItem() -> NSMenuItem {
        
    
        return NSMenuItem(title: "在Finder中显示", action: #selector(self.showInTheFinderAction), keyEquivalent: "f")
    }
    
    @objc func showInTheFinderAction() {
        
        let row = tableView.clickedRow
        
        let video = downloader.onlineVideos[row]
        
        NSWorkspace.shared.selectFile(video.downloadPath!.path + ".part", inFileViewerRootedAtPath: (video.localFolder?.path)!)
        
    }
    
}
