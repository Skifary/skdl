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
    override var windowNibName: String? {
        return "FIWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        setTableView()
        
        setWindow()
    }
    
    func setWindow() {
        self.window?.delegate = self
        
        self.window?.center()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        nameTableColumn.title = C.nameTableColumnTitle
        extTableColumn.title = C.extTableColumnTitle
        sizeTableColumn.title = C.sizeTableColumn
        
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
        
    }
    
    
    @IBAction func startDownload(_ sender: Any) {
        
        
    }
}


extension FIWindowController: NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        self.parent?.fiWindowController = nil
    }
    
}

extension FIWindowController: NSTableViewDelegate, NSTableViewDataSource {
    
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 50
        //return (files?.count)!
    }
    
    
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        var cell: NSCell?
        if (tableColumn?.isEqual(nameTableColumn))! {
            cell = NSTextFieldCell(textCell: (files?[0].name)!)
        } else if (tableColumn?.isEqual(extTableColumn))! {
            cell = NSTextFieldCell(textCell: (files?[0].ext)!)
        } else {
            cell = NSTextFieldCell(textCell: (files?[0].sizeDescription)!)
        }
        
        return cell
    }
    
    
    
}
