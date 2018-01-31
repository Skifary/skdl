//
//  PopoverViewController.swift
//  skdl
//
//  Created by Skifary on 20/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController {
    
    fileprivate struct Text {
        
        static let ChooseFolder = "Choose Folder"

        struct MenuItem {

            // setting
            
            static let Proxy = "Proxy"

            static let General = "General"
            
            static let About = "About"
            
            static let Quit = "Quit"
            
            // table view
            
            static let Suspend = "Suspend"
            
            static let Remove = "Remove"
            
            static let ShowInTheFinder = "Show in the Finder"

        }

    }
    
    //MARK:-
    
    var videos: [Video] {
        return VideoDownloader.shared.downloadingVideos
    }
    
    var popoverView: PopoverView {
        return view as! PopoverView
    }
    
    //MARK:-
    
    override func loadView() {
        view = PopoverView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK:- popover setting
    
    func setup() {
        setPopoverView()
        setTableView()
    }
    
    fileprivate func setPopoverView() {

//        let buttonAndAction: [NSButton : Selector?] = [
//            popoverView.newTaskButton : #selector(newTaskAction),
//            popoverView.settingButton : #selector(settingAction),
//            popoverView.openFolderButton : #selector(openFolderAction),
//        ]
//
//        buttonAndAction.forEach { (button,action) in
//            button.action = action
//            button.target = self
//        }
        
        NSButton.batchAddActions([
            popoverView.newTaskButton : #selector(newTaskAction),
            popoverView.settingButton : #selector(settingAction),
            popoverView.openFolderButton : #selector(openFolderAction),
            ], self)
    }

    @objc fileprivate func newTaskAction(_ sender: NSButton) {
        let vc = NewTaskViewController()
        presentViewControllerFromBottom(vc)
    }
    
    @objc fileprivate func settingAction(_ sender: NSButton) {
        let menu = settingMenu()
        
        NSMenu.popUpContextMenu(menu, with: NSApp.currentEvent!, for: sender)
    }
    
    @objc fileprivate func openFolderAction(_ sender: NSButton) {
        NSWorkspace.shared.selectFile(PV.localStoragePath, inFileViewerRootedAtPath: PV.localStoragePath!)
    }
    
    //MARK:- table view
    
    fileprivate func setTableView() {
        
        let tableView = popoverView.tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.menu = menuForTableViewRightClick()
        
        VideoDownloader.shared.registerStartHandle {
            self.popoverView.tableView.reloadData()
        }
        
        VideoDownloader.shared.registerEndHandle {
            self.popoverView.tableView.reloadData()
        }
    }
    
    fileprivate func menuForTableViewRightClick() -> NSMenu {
        let menu = NSMenu()
        menu.delegate = self
        return menu
    }
    
    //MARK:-
    
    fileprivate func settingMenu() -> NSMenu {
        let menu = NSMenu()
        
        let menuInfo: [String : Selector?] = [
            Text.MenuItem.Proxy : #selector(showProxyViewAction),
            Text.MenuItem.General : #selector(showGeneralViewAction),
            Text.MenuItem.About : #selector(showAboutViewAction),
            Text.MenuItem.Quit : #selector(advancedQuitAction)
        ]
        
//        let keyEquivalents: [String : String] = [
//            Text.MenuItem.Proxy : "",
//            Text.MenuItem.General : "",
//            Text.MenuItem.About : "",
//            Text.MenuItem.Quit : "q",
//        ]
        
        menuInfo.forEach { (title, action) in
            let item = NSMenuItem(title: title, action: action, keyEquivalent: "")
            menu.addItem(item)
        }
        
        return menu
    }

    @objc fileprivate func showProxyViewAction(sender: NSButton) {
        presentViewControllerFromBottom(ProxySettingViewController())
    }
    
    @objc fileprivate func showGeneralViewAction(sender: NSButton) {
        presentViewControllerFromBottom(GeneralSettingViewController())
    }
    
    @objc fileprivate func showAboutViewAction(sender: NSButton) {
        presentViewControllerFromBottom(AboutViewController())
    }
    
    @objc fileprivate func advancedQuitAction(sender: NSButton) {
        NSApp.terminate(nil)
    }
    
}

//MARK:- NSTableViewDelegate
extension PopoverViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cell = ContentCellView(frame: NSZeroRect)

//        cell.pauseButton.action = #selector(self.pauseButtonClick)
//        cell.pauseButton.target = self
//        
        cell.pauseButton.add(#selector(self.pauseButtonClick), self)
        
        let video = videos[row]
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
        return ContentCellView.Size.Height
    }
    
    @objc fileprivate func pauseButtonClick(sender: NSButton) {
        let cell = sender.superview as! ContentCellView
        if cell.video.state == Video.State.downloading {
            suspendDownload(cell.video)
        } else {
            startDownload(cell.video)
        }
        cell.setButtonImage(state: cell.video.state)
    }
    
    fileprivate func suspendDownload(_ video: Video) {
        video.task?.suspend()
    }
    
    fileprivate func startDownload(_ video: Video) {
        guard let task = video.task else {
            VideoDownloader.shared.download(with: video)
            return
        }
        task.resume()
    }
    
}

//MARK:- NSMenuDelegate
extension PopoverViewController: NSMenuDelegate {
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        menu.removeAllItems()
        
        let tableView = popoverView.tableView
        
        let row = tableView.clickedRow
        // -1的时候表示没有选中行
        if row  == -1 {
            return
        }
        let video = VideoDownloader.shared.downloadingVideos[row] //downloader.onlineVideos[row]
        let item = video.state == Video.State.downloading ? suspendDownloadMenuItem() : startDownloadMenuItem()
        let items = [item , removeDownloadMenuItem(), showInTheFinderMenuItem()]
        items.forEach { (item) in
            menu.addItem(item)
        }
    }
    
    //MARK:- menu item
    
    func startDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "Start Download", action: #selector(self.startDownloadAction), keyEquivalent: "s")
    }
    
    @objc func startDownloadAction() {
        let tableView = popoverView.tableView
        let row = tableView.clickedRow
        let cell = tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! ContentCellView
        let video = VideoDownloader.shared.downloadingVideos[row]
        startDownload(video)
        cell.setButtonImage(state: video.state)
    }
    
    func suspendDownloadMenuItem() -> NSMenuItem {
        
        return NSMenuItem(title: Text.MenuItem.Suspend, action: #selector(self.suspendDownloadAction), keyEquivalent: "p")
    }
    
    @objc func suspendDownloadAction() {
        let tableView = popoverView.tableView
        let row = tableView.clickedRow
        let cell = tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! ContentCellView
        let video = VideoDownloader.shared.downloadingVideos[row]
        
        suspendDownload(video)
        
        cell.setButtonImage(state: video.state)
    }
    
    func removeDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: Text.MenuItem.Remove, action: #selector(self.removeDownloadAction), keyEquivalent: "d")
    }
    
    @objc func removeDownloadAction() {
        let tableView = popoverView.tableView
        let row = tableView.clickedRow
        
        let video = VideoDownloader.shared.downloadingVideos[row]
        VideoDownloader.shared.remove(video: video)
        tableView.reloadData()
        
    }
    
    func showInTheFinderMenuItem() -> NSMenuItem {
        return NSMenuItem(title: Text.MenuItem.ShowInTheFinder, action: #selector(self.showInTheFinderAction), keyEquivalent: "f")
    }
    
    @objc func showInTheFinderAction() {
        let tableView = popoverView.tableView
        let row = tableView.clickedRow
        
        let video = VideoDownloader.shared.downloadingVideos[row]
        NSWorkspace.shared.selectFile(video.downloadPath!.path + ".part", inFileViewerRootedAtPath: (video.localFolder?.path)!)
    }
    
}

