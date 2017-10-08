//
//  LocalManagerViewController.swift
//  skdl
//
//  Created by Skifary on 03/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class LocalManagerViewController: NSViewController {

    
    weak var localManager = LocalManager.manager
    
    @IBOutlet weak var tableView: NSTableView!
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.menu = menuForRightClick()
    }
    
    func menuForRightClick() -> NSMenu {
        let menu = NSMenu()
        menu.delegate = self
        return menu
    }
}

extension LocalManagerViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (localManager?.localFiles.count)!
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = LocalTableCellView(frame: NSRect.zero)
        cellView.set(with: (localManager?.localFiles[row])!)
        cellView.file = localManager?.localFiles[row]
        cellView.addPlayButton(target: self, action: #selector(playButtonClick))
        cellView.addShowInTheFinderButton(target: self, action: #selector(showInTheFinderButtonClick))
        return cellView;
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 80
    }
    
    @objc func playButtonClick(sender: NSButton) {
        let cellView = sender.superview as! LocalTableCellView
        let file = cellView.file
        let player = PV.defaultPlayer
        if player  == "" {
            NSWorkspace.shared.openFile((file?.filePath.path)!)
        } else {
            NSWorkspace.shared.openFile((file?.filePath.path)!, withApplication: player)
        }
    }
    
    @objc func showInTheFinderButtonClick(sender: NSButton) {
        let cellView = sender.superview as! LocalTableCellView
        let file = cellView.file
        NSWorkspace.shared.selectFile(file?.filePath.path, inFileViewerRootedAtPath: (file?.localFolder?.path)!)
    }
    
}


extension LocalManagerViewController: NSMenuDelegate {
    
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

