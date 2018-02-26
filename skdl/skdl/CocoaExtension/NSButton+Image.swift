//
//  NSButton+Image.swift
//  skdl
//
//  Created by Skifary on 07/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

public extension NSButton {

    public static func button(with imageName: NSImage.Name) -> NSButton {
        return NSButton.button(with: NSImage(named: imageName))
    }
    
    public static func button(with image: NSImage?) -> NSButton {
        let button = NSButton()
        button.bezelStyle = NSButton.BezelStyle.circular
        button.title = ""
        button.image = image
        button.isBordered = false
        button.imageScaling = NSImageScaling.scaleProportionallyDown
        return button
    }
    
    public static func button(with text: String, fontSize: CGFloat = 25, color: NSColor = NSColor.black) -> NSButton {
        let image = NSImage.image(with: text, fontSize: fontSize, color: color)
        let button = NSButton.button(with: image)
        button.frame = NSMakeRect(0, 0, image.size.width, image.size.height)
        return button
    }
    
}
