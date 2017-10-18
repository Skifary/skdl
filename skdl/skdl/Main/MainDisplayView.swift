//
//  MainDisplayView.swift
//  skdl
//
//  Created by Skifary on 17/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class MainDisplayView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        
        self.layer?.backgroundColor = NSColor.blue.cgColor
        
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
