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
    
    var mainViewController: MainViewController?
    
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
        let toolbar = MainToolbar(identifier: NSToolbar.Identifier(kMainToolbarIdentifier))
        toolbar.delegate = self
        self.window?.toolbar = toolbar
    }
    
    fileprivate func setMainViewController() {
        mainViewController = MainViewController()
        window?.contentViewController = mainViewController
    }
    
    
    
}

//MARK:-
extension MainWindowController: NSToolbarDelegate {
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
                NSToolbarItem.Identifier(rawValue: kMainToolbarItemDownloaderIdentifier),
                NSToolbarItem.Identifier(rawValue: kMainToolbarItemFileManagerIdentifier),
        ]
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
                NSToolbarItem.Identifier.flexibleSpace,
                NSToolbarItem.Identifier(rawValue: kMainToolbarItemDownloaderIdentifier),
                NSToolbarItem.Identifier(rawValue: kMainToolbarItemFileManagerIdentifier),
                NSToolbarItem.Identifier.flexibleSpace,
        ]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        let toolbarItem = MainToolbarItem(itemIdentifier: NSToolbarItem.Identifier(itemIdentifier.rawValue))
        toolbarItem.target = self
        if itemIdentifier.rawValue == kMainToolbarItemDownloaderIdentifier {
            toolbarItem.action = #selector(downloadItemClick)
            toolbarItem.label = kMainToolbarItemDownloaderTitle
        } else {
            toolbarItem.action = #selector(fileItemClick)
            toolbarItem.label = kMainToolbarItemFileManagerTitle
        }
        return toolbarItem
        
    }
    
    @objc func downloadItemClick() {
        let mainVC = self.contentViewController as! MainViewController
        mainVC.showFileDownloadView()
    }
    
    @objc func fileItemClick() {
        let mainVC = self.contentViewController as! MainViewController
        mainVC.showFileManagerView()
    }
}
