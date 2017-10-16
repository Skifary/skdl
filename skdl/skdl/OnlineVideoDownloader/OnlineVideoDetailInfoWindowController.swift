//
//  OnlineVideoDetailInfoWindowController.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa


fileprivate let NameTableColumnTitle = "名称"

fileprivate let ExtTableColumnTitle = "扩展名"

fileprivate let SizeTableColumnTitle = "大小"

fileprivate let ChooseStoragePathTitle = "选择下载路径"

internal class OnlineVideoDetailInfoWindowController: NSWindowController {
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var popUpButton: NSPopUpButton!
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var nameTableColumn: NSTableColumn!
    @IBOutlet weak var extTableColumn: NSTableColumn!
    @IBOutlet weak var sizeTableColumn: NSTableColumn!
    
    //MARK:- var
    
    internal weak var parent: NewDownloadTaskWindowController!
    
    fileprivate let videos: [Video]

    override var windowNibName: NSNib.Name? {
        return NSNib.Name.init("OnlineVideoDetailInfoWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        setWindow()
        
        setTableView()
        
        setPopUpButton()
        
    }
    
    fileprivate func setWindow() {
        
        window?.delegate = self
        
        window?.center()
    
    }
    
    fileprivate func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        nameTableColumn.title = NameTableColumnTitle
        nameTableColumn.width = 400
        extTableColumn.title = ExtTableColumnTitle
        extTableColumn.width = 80
        sizeTableColumn.title = SizeTableColumnTitle
        sizeTableColumn.width = 80
        tableView.wantsLayer = true
        tableView.layer?.borderWidth = 0
    }
    
    fileprivate func setPopUpButton() {
        popUpButton.addItems(withTitles: PV.historyStoragePaths!)
        popUpButton.selectItem(withTitle: PV.localStoragePath!)
    }
    
    init(with videos: [Video]) {
        self.videos = videos
        super.init(window: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    override func showWindow(_ sender: Any?) {
        super.showWindow(nil)
        parent = sender as! NewDownloadTaskWindowController
    }
    
    //MARK:- IBAction
    
    @IBAction func selectPath(_ sender: Any) {
        guard let folderURL = FolderBrowser.chooseFolder(title: ChooseStoragePathTitle) else {
            return
        }
        if !popUpButton.itemTitles.contains(folderURL.path) {
            popUpButton.addItem(withTitle: folderURL.path)
        }
        popUpButton.selectItem(withTitle: folderURL.path)
    }
    
    @IBAction func startDownload(_ sender: Any) {
        
        guard let localFolder = popUpButton.selectedItem?.title else {
            Log.log("local folder is nil")
            Alert.warn("提示", "请选择保存路径")
            return
        }

        PV.saveLocalStoragePath(path: localFolder)
        PV.appendHistoryPath(path: localFolder)
        
        videos.forEach { (v) in
            v.localFolder = URL(string: "file://" + localFolder)
            OnlineVideoDownloader.shared.download(with: v)
        }
        
        close()
        parent.close()
    }
}


extension OnlineVideoDetailInfoWindowController: NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        parent.detailWindowController = nil
    }

}

extension OnlineVideoDetailInfoWindowController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        var text: String?
        if (tableColumn?.isEqual(nameTableColumn))! {
            text = videos[row].name
        } else if (tableColumn?.isEqual(extTableColumn))! {
            text = videos[row].ext
        } else {
            text = videos[row].sizeDescription
        }
        let cell = NSTextFieldCell(textCell: text!)
        return cell
    }
    
}
