//
//  AppDelegate.swift
//  skdl
//
//  Created by Skifary on 24/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {

    //MARK:- var
    
    internal var statusBarItem: NSStatusItem!
    
    internal var popover: NSPopover!
    
    internal var monitor: Any?

    //MARK:- application
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // 注册默认自定义偏好
        UserDefaults.standard.register(defaults: Preference.defaultPreference)
 
        
      //  setMenu()
       statusBarItem = statusItem()
        
     //   setStatusBar()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
        VideoManager.manager.quitAndSave()
    
    }

//    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
//        if (!flag) {
//            NSApp.activate(ignoringOtherApps: false)
//            NSApp.windows.last?.windowController?.showWindow(nil)
//            NSApp.windows.last?.center()
//        }
//        return true
//    }

    //MARK:- IBAction
    
//    @IBAction func showPreference(_ sender: Any) {
//        
//        let viewControllers: [NSViewController] = [PreferenceGeneralViewController()]
//        prefecenceWindowController = MASPreferencesWindowController(viewControllers: viewControllers, title: AppData.PreferenceTitle)
//        prefecenceWindowController?.window?.delegate = self
//        prefecenceWindowController?.showWindow(nil)
//        prefecenceWindowController?.window?.center()
//        
//    }
    
}


//extension AppDelegate: NSWindowDelegate {
//
//    func windowWillClose(_ notification: Notification) {
//        if (prefecenceWindowController?.window?.isEqual(notification.object))! {
//            prefecenceWindowController = nil
//        }
//    }
//
//}

