//
//  MainWindowController.swift
//  skdl
//
//  Created by Skifary on 26/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate let DownloadToolbarItemTitle = "下载"

fileprivate let LocalToolbarItemTitle = "已完成"


internal class MainWindowController: NSWindowController {
    
    fileprivate struct Identifier {
        static let Toolbar = "com.skdl.maintoolbar"
        
        struct ToolbarItem {
            static let Download = "com.skdl.toolbaritem.download"
            static let Local = "com.skdl.toolbaritem.Local"
        }
    }
    
    //MARK:- life cycle
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        setWindow()
        setMainViewController()
        
        
        
    }
    
    //MARK:- file private
    fileprivate func setWindow() {
        
        self.window = MainWindow()
        
        setToolbar()
    }
    
    fileprivate func setToolbar() {
        let toolbar = MainToolbar(identifier: NSToolbar.Identifier(Identifier.Toolbar))
        toolbar.delegate = self
        self.window?.toolbar = toolbar
    }
    
    fileprivate func setMainViewController() {
        window?.contentViewController = MainViewController()
    }
    
    
    
}

//MARK:-
extension MainWindowController: NSToolbarDelegate {
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier(rawValue: Identifier.ToolbarItem.Download),
            NSToolbarItem.Identifier(rawValue: Identifier.ToolbarItem.Local),
        ]
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier.flexibleSpace,
            NSToolbarItem.Identifier(rawValue: Identifier.ToolbarItem.Download),
            NSToolbarItem.Identifier(rawValue: Identifier.ToolbarItem.Local),
            NSToolbarItem.Identifier.flexibleSpace,
        ]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        let toolbarItem = MainToolbarItem(itemIdentifier: NSToolbarItem.Identifier(itemIdentifier.rawValue))
        toolbarItem.target = self
        if itemIdentifier.rawValue == Identifier.ToolbarItem.Download {
            toolbarItem.action = #selector(downloadItemClick)
            toolbarItem.label = DownloadToolbarItemTitle
        } else {
            toolbarItem.action = #selector(fileItemClick)
            toolbarItem.label = LocalToolbarItemTitle
        }
        return toolbarItem
        
    }
    
    @objc func downloadItemClick() {
        let mainVC = self.contentViewController as! MainViewController
        mainVC.showDownloadView()
    }
    
    @objc func fileItemClick() {
        let mainVC = self.contentViewController as! MainViewController
        mainVC.showManagerView()
    }
}

