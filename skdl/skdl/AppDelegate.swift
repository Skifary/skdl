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

    //MARK:- var
    
    var newTaskWindowController: NTWindowController?
    
    var prefecenceWindowController: MASPreferencesWindowController?

    //MARK:- application
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // 注册默认自定义偏好
        UserDefaults.standard.register(defaults: Preference.defaultPreference)
 
        setMenu()
    
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
        DLFileManager.manager.quitAndSave()
    
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if (!flag) {
            NSApp.activate(ignoringOtherApps: false)
//            for window in NSApp.windows {
//                if window is MainWindow {
//                    window.windowController?.showWindow(nil)
//                    window.center()
//                    break;
//                }
//            }
            NSApp.windows.last?.windowController?.showWindow(nil)
            NSApp.windows.last?.center()
        }
        return true
    }

    //MARK:- IBAction
    
    @IBAction func showPreference(_ sender: Any) {
        
        let viewControllers: [NSViewController] = [PGeneralViewController()]
        
        prefecenceWindowController = MASPreferencesWindowController(viewControllers: viewControllers, title: PreferenceDefine.kTitle)
        
        prefecenceWindowController?.window?.delegate = self
        
        prefecenceWindowController?.showWindow(nil)
        
        prefecenceWindowController?.window?.center()
        
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
        fmi.keyEquivalentModifierMask = [NSEvent.ModifierFlags.command]
        return fmi
    }
    
    @objc fileprivate func newTaskAction() {
        
        if newTaskWindowController == nil {
            newTaskWindowController = NTWindowController()
        }
        
        if (newTaskWindowController?.window?.isVisible)! {
            return
        }
        newTaskWindowController?.showWindow(nil)
        newTaskWindowController?.window?.center()
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
        fmi.keyEquivalentModifierMask = [NSEvent.ModifierFlags.command]
        return fmi
    }
    
    @objc fileprivate func closeAction() {
        NSApp.keyWindow?.close()
    }
    
}


extension AppDelegate: NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        if (prefecenceWindowController?.window?.isEqual(notification.object))! {
            prefecenceWindowController = nil
        }
    }
    
}
