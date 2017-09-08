//
//  MainWindowController.swift
//  skdl
//
//  Created by Skifary on 26/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate struct Constant {
    
}

fileprivate typealias C = Constant

class MainWindowController: NSWindowController {
    
    
    
    //MARK:- life cycle
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        setWindow()
       
    }
    
    //MARK:- file private
    fileprivate func setWindow() {
        self.window = MainWindow()
        
        setToolbar()
    }
    
    fileprivate func setToolbar() {
        let toolbar = MainToolbar(identifier: kMainToolbarIdentifier)
        toolbar.delegate = self
        self.window?.toolbar = toolbar
    }
    
    
    
}

//MARK:-
extension MainWindowController: NSToolbarDelegate {
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return [
                kMainToolbarItemDownloaderIdentifier,
                kMainToolbarItemFileManagerIdentifier,
        ]
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return [
                NSToolbarFlexibleSpaceItemIdentifier,
                kMainToolbarItemDownloaderIdentifier,
                kMainToolbarItemFileManagerIdentifier,
                NSToolbarFlexibleSpaceItemIdentifier,
        ]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        let toolbarItem = MainToolbarItem(itemIdentifier: itemIdentifier)
        toolbarItem.target = self
        if itemIdentifier == kMainToolbarItemDownloaderIdentifier {
            toolbarItem.action = #selector(downloadItemClick)
            toolbarItem.label = kMainToolbarItemDownloaderTitle
        } else {
            toolbarItem.action = #selector(fileItemClick)
            toolbarItem.label = kMainToolbarItemFileManagerTitle
        }
        return toolbarItem
        
    }
    
    func downloadItemClick() {
        print("downloadItemClick")
    }
    
    func fileItemClick() {
         print("fileItemClick")
    }
}
