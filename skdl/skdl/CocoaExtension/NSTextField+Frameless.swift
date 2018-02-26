//
//  NSTextField+Frameless.swift
//  skdl
//
//  Created by Skifary on 27/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class RoundedTextFieldCell: NSTextFieldCell {
    
    var borderColor: NSColor = .clear
    var cornerRadius: CGFloat = 3
    
    override func draw(withFrame cellFrame: NSRect, in controlView: NSView) {
        let bounds = NSBezierPath(roundedRect: cellFrame, xRadius: cornerRadius, yRadius: cornerRadius)
        bounds.addClip()
        super.draw(withFrame: cellFrame, in: controlView)
        if borderColor != .clear {
            bounds.lineWidth = 2
            borderColor.setStroke()
            bounds.stroke()
        }
    }
}

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
