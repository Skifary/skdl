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
    
    internal var popoverCloseEvent: [()->Void] = []

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
    
    //MARK:-

    internal func registerForPopoverCloseEvent(_ event: @escaping ()->Void) {
        popoverCloseEvent.append(event)
    }
}




