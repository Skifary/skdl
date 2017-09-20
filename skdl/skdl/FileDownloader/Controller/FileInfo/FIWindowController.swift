//
//  FIWindowController.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate struct Constant {
    

    static let nameTableColumnTitle = "名称"
    
    static let extTableColumnTitle = "扩展名"
    
    static let sizeTableColumn = "大小"
    
    static let chooseStoragePathTitle = "选择下载路径"
    
}

fileprivate typealias C = Constant

class FIWindowController: NSWindowController {
    
    //MARK:- IBOutlet
    
    @IBOutlet weak var popUpButton: NSPopUpButton!
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var nameTableColumn: NSTableColumn!
    @IBOutlet weak var extTableColumn: NSTableColumn!
    @IBOutlet weak var sizeTableColumn: NSTableColumn!
    
    //MARK:- var
    
    weak var parent: NTWindowController?
    
    let files: [DLFile]?
    
    //MARK:- life cycle
//    override var windowNibName: String? {
//        return "FIWindowController"
//    }
//    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name.init("FIWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        
        basicSetting()

    }
    
    func basicSetting() {
        setWindow()
        setTableView()
        setPopUpButton()
    }
    
    func setWindow() {
        self.window?.delegate = self
        
        self.window?.center()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        nameTableColumn.title = C.nameTableColumnTitle
        nameTableColumn.width = 400
        extTableColumn.title = C.extTableColumnTitle
        extTableColumn.width = 80
        sizeTableColumn.title = C.sizeTableColumn
        sizeTableColumn.width = 80
        tableView.wantsLayer = true
        tableView.layer?.borderWidth = 0
    }
    
    func setPopUpButton() {
        popUpButton.addItems(withTitles: PV.historyStoragePaths!)
        popUpButton.selectItem(withTitle: PV.localStoragePath!)
    }
    
    init(files: [DLFile]?) {
        self.files = files
        super.init(window: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
       // print("deinit")
    }
    
    override func showWindow(_ sender: Any?) {
        super.showWindow(nil)
        parent = sender as? NTWindowController
    }
    
    //MARK:- IBAction
    
    @IBAction func selectPath(_ sender: Any) {
        let folderURL = FolderBrowser.chooseFolder(title: C.chooseStoragePathTitle)
        if folderURL == nil {
            return
        }
        if !popUpButton.itemTitles.contains(folderURL!) {
            popUpButton.addItem(withTitle: folderURL!)
        }
        popUpButton.selectItem(withTitle: folderURL!)
    }
    
    @IBAction func startDownload(_ sender: Any) {
        let localFolder = (popUpButton.selectedItem?.title)!
        PV.saveLocalStoragePath(path: localFolder)
        PV.appendHistoryPath(path: localFolder)
        
        for file in files! {
            file.local = localFolder + "/" + file.name! + "." + file.ext!

            DownloadManager.manager.download(with: file)
        }
        
    }
}


extension FIWindowController: NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        self.parent?.fiWindowController = nil
    }
    
}

extension FIWindowController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (files?.count)!
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        var cell: NSCell?
        if (tableColumn?.isEqual(nameTableColumn))! {
            cell = NSTextFieldCell(textCell: (files?[row].name)!)
        } else if (tableColumn?.isEqual(extTableColumn))! {
            cell = NSTextFieldCell(textCell: (files?[row].ext)!)
        } else {
            cell = NSTextFieldCell(textCell: (files?[row].sizeDescription)!)
        }
        
        return cell
    }
    
}
