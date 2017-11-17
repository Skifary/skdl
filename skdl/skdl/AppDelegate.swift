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
    
    private var isReady: Bool = false // check if finish launching
    
    private var pendingURL: String?

    //MARK:- application
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        if !isReady {
            UserDefaults.standard.register(defaults: Preference.defaultPreference)
            statusBarItem = statusItem()

            isReady = true
        }

        // if have pending open request
        if let url = pendingURL {
            parsePendingURL(url)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
        VideoManager.manager.quitAndSave()
    
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        // register for url event
        NSAppleEventManager.shared().setEventHandler(self, andSelector: #selector(self.handleURLEvent(event:withReplyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
    
    
    @objc fileprivate func handleURLEvent(event: NSAppleEventDescriptor, withReplyEvent replyEvent: NSAppleEventDescriptor) {
        guard let url = event.paramDescriptor(forKeyword: keyDirectObject)?.stringValue else { return }
        if isReady {
            parsePendingURL(url)
        } else {
            pendingURL = url
        }
    }
    
    private func parsePendingURL(_ url: String) {
        guard let parsed = NSURLComponents(string: url) else { return }
        // links
        if let host = parsed.host, host == "weblink" {
            guard let urlValue = (parsed.queryItems?.first { $0.name == "url" }?.value) else { return }
            DispatchQueue.global().async {
                VideoDownloader.shared.download(with: urlValue)
            }
        }
    }
    
    //MARK:-

    internal func registerForPopoverCloseEvent(_ event: @escaping ()->Void) {
        popoverCloseEvent.append(event)
    }
}




