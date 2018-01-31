//
//  NSImage+Text.swift
//  skdl
//
//  Created by Skifary on 21/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

public extension NSImage {

    public static func image(with text: String, fontSize: CGFloat, color: NSColor) -> NSImage {
        
        let scaleFactor = NSScreen.main!.backingScaleFactor
        let nsText = NSString(string: text)
        
        let font = NSFont.systemFont(ofSize: fontSize * scaleFactor, weight: .thin)
        
        let attributes = [
            NSAttributedStringKey.font: font,
            NSAttributedStringKey.foregroundColor: color,
        ]
        
        let size = nsText.size(withAttributes: attributes)
        
        let image = drawImageInNewCGContext(size: size, useNSGraphicsContext: true) { (context) in
            nsText.draw(at: NSPoint.zero, withAttributes: attributes)
        }
        
        return image;
    }
    
}
