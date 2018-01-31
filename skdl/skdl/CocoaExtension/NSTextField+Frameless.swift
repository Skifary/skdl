//
//  NSTextField+Frameless.swift
//  skdl
//
//  Created by Skifary on 27/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa


extension NSTextField {
    
    static func framelessTextField() -> NSTextField {
        
        let textfield = NSTextField(frame: NSZeroRect)
        textfield.isBordered = false
        textfield.focusRingType = .none
        textfield.drawsBackground = false
        
        textfield.textColor = NSColor.black
        
        // single line
        textfield.cell?.lineBreakMode = .byTruncatingMiddle
        textfield.cell?.truncatesLastVisibleLine = true
        
        return textfield
    }
    
}
