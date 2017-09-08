//
//  MainWindow.swift
//  skdl
//
//  Created by Skifary on 26/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa



fileprivate struct Constant {
    
    static let windowDefaultWidth: Int = 900
    static let windowDefaultHeight: Int = 600
    
}

fileprivate typealias C = Constant

class MainWindow: NSWindow {

    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        let frame = NSRect(x: 0, y: 0, width: C.windowDefaultWidth, height: C.windowDefaultHeight)
        super.init(contentRect: frame, styleMask: [.borderless, .titled, .closable, .miniaturizable, .resizable], backing: .buffered, defer: true)
        self.center()
        self.maxSize = frame.size
        self.minSize = frame.size
    }
    
}
