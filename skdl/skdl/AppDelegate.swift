//
//  AppDelegate.swift
//  skdl
//
//  Created by Skifary on 24/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    lazy var newTaskWindowController: NTWindowController = {
        return NTWindowController()
    }()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        setMenu()
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if (!flag) {
            NSApp.activate(ignoringOtherApps: false)
            for window in NSApp.windows {
                if window is MainWindow {
                    window.windowController?.showWindow(nil)
                    window.center()
                    break;
                }
            }
        }
        return true
    }

    
    //MARK:- menu
    
    fileprivate func setMenu() {

        let m = NSApp.menu
        let mis: [NSMenuItem] = [fileMenuItem(),windowMenuItem()]
        mis.forEach { (mi) in
            m?.addItem(mi)
        }
        
    }
    
    // file menu
    fileprivate func fileMenuItem() -> NSMenuItem {
        
        let fmi = NSMenuItem()
        fmi.title = MT.kFileTitle
        fmi.submenu = NSMenu(title: MT.kFileTitle)
        let mis: [NSMenuItem] = [newTaskMenuItem()]
        mis.forEach { (mi) in
            fmi.submenu?.addItem(mi)
        }
        return fmi
    }
    
    fileprivate func newTaskMenuItem() -> NSMenuItem {
        let fmi = NSMenuItem(title: MT.kNewTaskTitle, action: #selector(newTaskAction), keyEquivalent: "n")
        fmi.keyEquivalentModifierMask = [.command]
        return fmi
    }
    
    @objc fileprivate func newTaskAction() {
        if (newTaskWindowController.window?.isVisible)! {
            return
        }
        newTaskWindowController.showWindow(nil)
        newTaskWindowController.window?.center()
    }
    
    // window menu
    fileprivate func windowMenuItem() -> NSMenuItem {
        let fmi = NSMenuItem()
        fmi.title = MT.kWindowTitle
        fmi.submenu = NSMenu(title: MT.kWindowTitle)
        let mis: [NSMenuItem] = [closeMenuItem()]
        mis.forEach { (mi) in
            fmi.submenu?.addItem(mi)
        }
        return fmi
    }
    
    fileprivate func closeMenuItem() -> NSMenuItem {
        let fmi = NSMenuItem(title: MT.kNewTaskTitle, action: #selector(closeAction), keyEquivalent: "w")
        fmi.keyEquivalentModifierMask = [.command]
        return fmi
    }
    
    @objc fileprivate func closeAction() {
        NSApp.keyWindow?.close()
    }
    
}

