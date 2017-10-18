//
//  MainWindow.swift
//  skdl
//
//  Created by Skifary on 26/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate let DefaultWindowWidth: Int = 750
fileprivate let DefaultWindowHeight: Int = 500

internal class MainWindow: NSWindow {

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing bufferingType: NSWindow.BackingStoreType, defer flag: Bool) {
        let frame = NSRect(x: 0, y: 0, width: DefaultWindowWidth, height: DefaultWindowHeight)
        super.init(contentRect: frame, styleMask: [.borderless, .titled, .closable, .miniaturizable, .resizable, .fullScreen], backing: .buffered, defer: true)
        self.center()
        self.maxSize = frame.size
        self.minSize = frame.size
        // 隐藏标题栏
        self.titlebarAppearsTransparent = true
        self.titleVisibility = .hidden
        // 识别子view 的拖拽
        self.isMovableByWindowBackground = true
    }
    
}
