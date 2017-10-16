//
//  AppDelegate+Menu.swift
//  skdl
//
//  Created by Skifary on 16/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

fileprivate struct MenuTitle {
    /** file */
    static let File = "File"
    static let NewTask = "New Task"
    
    /** window*/
    static let Window = "Window"
    static let Close = "Close"
    
}

extension AppDelegate {
    
    //MARK:- menu
    
    internal func setMenu() {
        
        let menu = NSApp.menu
        let menuItems: [NSMenuItem] = [fileMenuItem(),windowMenuItem()]
        menuItems.forEach { (item) in
            menu?.addItem(item)
        }
        
    }
    
    // file menu
    fileprivate func fileMenuItem() -> NSMenuItem {
        
        let item = NSMenuItem()
        item.title = MenuTitle.File
        item.submenu = NSMenu(title: MenuTitle.File)
        let menuItems: [NSMenuItem] = [newTaskMenuItem()]
        menuItems.forEach { (sub) in
            item.submenu?.addItem(sub)
        }
        return item
    }
    
    fileprivate func newTaskMenuItem() -> NSMenuItem {
        
        let item = NSMenuItem(title: MenuTitle.NewTask, action: #selector(newTaskAction), keyEquivalent: "n")
        item.keyEquivalentModifierMask = [NSEvent.ModifierFlags.command]
        return item
    }
    
    @objc fileprivate func newTaskAction() {
        
        if newTaskWindowController == nil {
            newTaskWindowController = NewDownloadTaskWindowController()
        }
        
        if (newTaskWindowController?.window?.isVisible)! {
            return
        }
        newTaskWindowController?.showWindow(nil)
        newTaskWindowController?.window?.center()
    }
    
    // window menu
    fileprivate func windowMenuItem() -> NSMenuItem {
        let item = NSMenuItem()
        item.title = MenuTitle.Window
        item.submenu = NSMenu(title: MenuTitle.Window)
        let menuItems: [NSMenuItem] = [closeMenuItem()]
        menuItems.forEach { (sub) in
            item.submenu?.addItem(sub)
        }
        return item
    }
    
    fileprivate func closeMenuItem() -> NSMenuItem {
        let item = NSMenuItem(title: MenuTitle.Close, action: #selector(closeAction), keyEquivalent: "w")
        item.keyEquivalentModifierMask = [NSEvent.ModifierFlags.command]
        return item
    }
    
    @objc fileprivate func closeAction() {
        NSApp.keyWindow?.close()
    }
    
}
