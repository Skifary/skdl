//
//  NSButton+ImageButton.swift
//  skdl
//
//  Created by Skifary on 07/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

public extension NSButton {

    public static func button(with image: NSImage?) -> NSButton {
        let button = NSButton()
        button.bezelStyle = NSButton.BezelStyle.circular
        button.title = ""
        button.image = image
        button.isBordered = false
        button.imageScaling = NSImageScaling.scaleProportionallyDown
        return button
    }
    
}
