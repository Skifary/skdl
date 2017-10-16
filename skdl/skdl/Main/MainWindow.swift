//
//  MainWindow.swift
//  skdl
//
//  Created by Skifary on 26/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate let DefaultWindowWidth: Int = 900
fileprivate let DefaultWindowHeight: Int = 600

internal class MainWindow: NSWindow {

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing bufferingType: NSWindow.BackingStoreType, defer flag: Bool) {
        let frame = NSRect(x: 0, y: 0, width: DefaultWindowWidth, height: DefaultWindowHeight)
        super.init(contentRect: frame, styleMask: [NSWindow.StyleMask.borderless, NSWindow.StyleMask.titled, NSWindow.StyleMask.closable, NSWindow.StyleMask.miniaturizable, NSWindow.StyleMask.resizable], backing: .buffered, defer: true)
        self.center()
        self.maxSize = frame.size
        self.minSize = frame.size
    }
    
}
