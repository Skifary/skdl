//
//  PopoverViewController.swift
//  skdl
//
//  Created by Skifary on 20/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class PopoverViewController: NSViewController {
    
    fileprivate struct Text {
        
        struct Title {
            static let ChooseFolder = "Choose Folder"
            
            static let MenuItemQuit = "Quit"
            
            static let MenuItemSuspend = "Suspend"
            
            static let MenuItemRemove = "Remove"
            
            static let MenuItemShowInTheFinder = "Show in the Finder"
            
            static let MenuItemProxy = "Proxy"
        }
        
    }
    
    internal var videos: [Video] {
       return VideoDownloader.shared.downloadingVideos
    }
    

    internal var popoverView: PopoverView {
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
    
    override func viewWillDisappear() {

        hideBottomView()
    }
    
    override func mouseDown(with event: NSEvent) {
        
        
        hideBottomView()

    }
    
    //MARK:- popover setting
    
    func setup() {
        setPopoverView()
        
        setTableView()
        

        
    }
    
    fileprivate func setPopoverView() {
        
        guard let popoverView = view as? PopoverView else {
            Log.log("popover view error!")
            return
        }
        
        popoverView.addButton.action = #selector(addAction)
        popoverView.addButton.target = self
        
        popoverView.settingButton.action = #selector(settingAction)
        popoverView.settingButton.target = self
        
        popoverView.openFolderButton.action = #selector(openFolderAction)
        popoverView.openFolderButton.target = self
        
        popoverView.addView.downloadButton.action = #selector(downloadAction)
        popoverView.addView.downloadButton.target = self
        
        popoverView.settingView.saveFolderPathLabel.stringValue = PV.localStoragePath!
        
        popoverView.settingView.chooseButton.action = #selector(chooseAction)
        popoverView.settingView.chooseButton.target = self
        
        popoverView.settingView.advancedButton.action = #selector(advancedAction)
        popoverView.settingView.advancedButton.target = self
        
        hideAddView()
        hideSettingView()
        
        popoverView.proxyView.registerForHideEvent {
            
            self.hideProxyView()
            
        }
        
        let appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.registerForPopoverCloseEvent {
            if !self.popoverView.proxyView.isHidden {
                self.hideProxyView()
            }
        }

    }
    
    internal func hideBottomView() {
        if !popoverView.addView.isHidden {
            hideAddView()
        }
        
        if !popoverView.settingView.isHidden {
            hideSettingView()
        }
    }
    
    @objc fileprivate func addAction(_ sender: NSButton) {
        
        guard popoverView.addView.isHidden else {
            hideAddView()
            return
        }
        
        showAddView()
        
    }
    
    @objc fileprivate func settingAction(_ sender: NSButton) {
        
        guard popoverView.settingView.isHidden else {
            hideSettingView()
            return
        }
        
        showSettingView()
        
    }
    
    @objc fileprivate func openFolderAction(_ sender: NSButton) {

        NSWorkspace.shared.selectFile(PV.localStoragePath, inFileViewerRootedAtPath: PV.localStoragePath!)
        
        hideBottomView()

    }
    
    @objc fileprivate func downloadAction(_ sender: NSButton) {
        
        hideAddView()
        
        let url = popoverView.addView.urlTextField.stringValue

        DispatchQueue.global().async {
            self.download(with: url)
        }
        
    }
    
    @objc fileprivate func chooseAction(_ sender: NSButton) {
        
        guard let url = FolderBrowser.chooseFolder(title: Text.Title.ChooseFolder) else { return }
        
        PV.localStoragePath = url.path

        popoverView.settingView.saveFolderPathLabel.stringValue = url.path
        
    }
    
    @objc fileprivate func advancedAction(_ sender: NSButton) {
        
        let menu = menuForAdvanced()
        
        NSMenu.popUpContextMenu(menu, with: NSApp.currentEvent!, for: sender)
        
    }
    
   // fileprivate func
    
    fileprivate func showAddView() {
        hideSettingView()
        changePopoverContentSize(with: PopoverView.Size.AddHeight)
        popoverView.addView.isHidden = false
    }
    
    fileprivate func hideAddView() {
        changePopoverContentSize(with: 0)
        popoverView.addView.isHidden = true
    }
    
    fileprivate func showSettingView() {
        hideAddView()
        changePopoverContentSize(with: PopoverView.Size.SettingHeight)
        popoverView.settingView.isHidden = false
    }
    
    fileprivate func hideSettingView() {
        changePopoverContentSize(with: 0)
        popoverView.settingView.isHidden = true
    }
    
    fileprivate func changePopoverContentSize(with increaseHeight: CGFloat) {

        let appDelegate = NSApp.delegate as? AppDelegate
        guard let popover = appDelegate?.popover  else {
            Log.log("popover is nil!")
            return
        }
 
        popover.contentSize = NSMakeSize(PopoverView.Size.Content.width, PopoverView.Size.Content.height + increaseHeight)
        
    }
    
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
    
    fileprivate func menuForAdvanced() -> NSMenu {
        let menu = NSMenu()
        
        let proxyItem = NSMenuItem(title: Text.Title.MenuItemProxy, action: #selector(advancedProxyAction), keyEquivalent: "")
        menu.addItem(proxyItem)
        let quitItem = NSMenuItem(title: Text.Title.MenuItemQuit, action: #selector(advancedQuitAction), keyEquivalent: "q")
        menu.addItem(quitItem)

        return menu
    }
    
    @objc fileprivate func advancedQuitAction(sender: NSButton) {
        
        NSApp.terminate(nil)
        
    }
    
    @objc fileprivate func advancedProxyAction(sender: NSButton) {
        
        showProxyView()
    }
    
    fileprivate func showProxyView() {
        
        let proxyView = popoverView.proxyView
        
        proxyView.setProxyType(with: PV.proxyType!)
        
        proxyView.addressTextField.stringValue = PV.proxyAddress ?? ""
        
        proxyView.portTextField.stringValue = PV.proxyPort ?? ""
        
        proxyView.isHidden = false
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.2
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            
            popoverView.proxyViewTopConstraint.animator().constant = -PopoverView.Size.ProxyHeight

        })
        
    }
    
    fileprivate func hideProxyView() {
        
        let proxyView = popoverView.proxyView
        
        PV.proxyType = proxyView.proxyType()
        
        PV.proxyAddress = proxyView.addressTextField.stringValue
        
        PV.proxyPort = proxyView.portTextField.stringValue

        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.2
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            
            popoverView.proxyViewTopConstraint.animator().constant = 0
            
        }) {
            proxyView.isHidden = true
        }

    }
    
    //MARK:-
    
    internal func download(with url: String) {
        
        guard url != "" else {
            let error = "url is nil!"
            Log.log(error)
            showError(error)
            return
        }
        
//        guard ytdlController.shared.isURLAvailable(url: url) else {
//            let error = "url is unavailable!"
//            Log.log(error)
//            showError(error)
//            return
//        }
        print("download")
        var isPorxyUrl = false
        
        if !ytdlController.shared.isURLAvailable(url: url) {
            if !ytdlController.shared.isURLAvailableInProxy(url: url) {
                let error = "url is unavailable!"
                Log.log(error)
                showError(error)
                return
            }
            print("is proxy url")
            isPorxyUrl = true
        }
        print("dump json start")
        guard let json = ytdlController.shared.dumpJson(url: url, isPorxyUrl) else {
            let error = "json is unavailable!"
            Log.log(error)
            showError(error)
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
        
        video.needProxy = isPorxyUrl
        VideoDownloader.shared.download(with: video)
    }
    
    func showError(_ error: String) {
        let addView = popoverView.addView
        if Thread.isMainThread {
            showAddView()
            addView.showError(with: error)
        } else {
            DispatchQueue.main.async {
                self.showAddView()
                addView.showError(with: error)
            }
        }
    }
    
}

//MARK:- NSTableViewDelegate
extension PopoverViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cell = ContentCellView(frame: NSZeroRect)

       // cell.nameLabel.stringValue = "这是名字这是名字这是名字这是名字这是名字"
        
        cell.pauseButton.action = #selector(self.pauseButtonClick)
        cell.pauseButton.target = self

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
    
    func startDownloadMenuItem() -> NSMenuItem {
        return NSMenuItem(title: "开始下载", action: #selector(self.startDownloadAction), keyEquivalent: "s")
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
        
        return NSMenuItem(title: Text.Title.MenuItemSuspend, action: #selector(self.suspendDownloadAction), keyEquivalent: "p")
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
        return NSMenuItem(title: Text.Title.MenuItemRemove, action: #selector(self.removeDownloadAction), keyEquivalent: "d")
    }
    
    @objc func removeDownloadAction() {
        let tableView = popoverView.tableView
        let row = tableView.clickedRow
        
        let video = VideoDownloader.shared.downloadingVideos[row]
        VideoDownloader.shared.remove(video: video)
        tableView.reloadData()
        
    }
    
    func showInTheFinderMenuItem() -> NSMenuItem {

        return NSMenuItem(title: Text.Title.MenuItemShowInTheFinder, action: #selector(self.showInTheFinderAction), keyEquivalent: "f")
    }
    
    @objc func showInTheFinderAction() {
        let tableView = popoverView.tableView
        let row = tableView.clickedRow
        
        let video = VideoDownloader.shared.downloadingVideos[row]
        
        NSWorkspace.shared.selectFile(video.downloadPath!.path + ".part", inFileViewerRootedAtPath: (video.localFolder?.path)!)
        
    }
    
}


