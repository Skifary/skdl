//
//  OfflineVideoManagerViewController.swift
//  skdl
//
//  Created by Skifary on 03/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class OfflineVideoManagerViewController: NSViewController {

    internal weak var offlineVideoManager: OfflineVideoManager! = OfflineVideoManager.manager
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setTableView()
        
        OnlineVideoDownloader.shared.registerEndHandle {
            self.tableView.reloadData()
        }
        
    }
    
    fileprivate func setTableView() {
        // 除去蓝色边框
        tableView.wantsLayer = true
        tableView.layer?.borderWidth = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.menu = menuForRightClick()
    }
    
    fileprivate func menuForRightClick() -> NSMenu {
        let menu = NSMenu()
        menu.delegate = self
        return menu
    }
}

extension OfflineVideoManagerViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return offlineVideoManager.offlineVideos.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cell = OfflineVideoManagerCellView(frame: NSRect.zero)
        cell.set(with: offlineVideoManager.offlineVideos[row])
        cell.video = offlineVideoManager.offlineVideos[row]
        cell.addPlayButton(target: self, action: #selector(playButtonClick))
        cell.addShowInTheFinderButton(target: self, action: #selector(showInTheFinderButtonClick))
        return cell;
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 80
    }
    
    @objc fileprivate func playButtonClick(sender: NSButton) {
        let cell = sender.superview as! OfflineVideoManagerCellView
        let video = cell.video!
        let player = PV.defaultPlayer
        
        guard let path = video.filePath?.path else {
            Log.logWithCallStack("file path is nil")
            return
        }
        if player  == "" {
            NSWorkspace.shared.openFile(path)
        } else {
            NSWorkspace.shared.openFile(path, withApplication: player)
        }
    }
    
    @objc fileprivate func showInTheFinderButtonClick(sender: NSButton) {
        let cell = sender.superview as! OfflineVideoManagerCellView
        let video = cell.video!
        guard let path = video.filePath?.path else {
            Log.logWithCallStack("file path is nil")
            return
        }
        NSWorkspace.shared.selectFile(path, inFileViewerRootedAtPath: (video.localFolder?.path)!)
    }
    
}


extension OfflineVideoManagerViewController: NSMenuDelegate {
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        menu.removeAllItems()
        // -1的时候表示没有选中行
        if tableView.clickedRow == -1 {
            return
        }
        let items = [removeDownloadMenuItem(), showInTheFinderMenuItem()]
        
        items.forEach { (item) in
            menu.addItem(item)
        }
    }
    
    fileprivate func removeDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "删除任务", action: #selector(self.removeDownloadAction), keyEquivalent: "d")
    }
    
    @objc fileprivate func removeDownloadAction() {
        
      //  let file = // localManager?.localFiles[tableView.clickedRow]
        
        print("remove download")
    }
    
    func showInTheFinderMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "在Finder中显示", action: #selector(self.showInTheFinderAction), keyEquivalent: "f")
    }
    
    @objc fileprivate func showInTheFinderAction() {
        
    //    let file = localManager?.localFiles[tableView.clickedRow]
        
        
     //   NSWorkspace.shared.selectFile(file?.filePath.path, inFileViewerRootedAtPath: (file?.localFolder?.path)!)
        
        print("show in the finder")
    }
    
}

