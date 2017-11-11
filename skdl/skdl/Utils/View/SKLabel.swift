//
//  SKLabel.swift
//  skdl
//
//  Created by Skifary on 19/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate let DefaultTitle = "Label"

public class SKLabel: NSTextField {

    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        isEditable = false
        isBordered = false
        focusRingType = .none
        drawsBackground = false
        stringValue = DefaultTitle
        textColor = NSColor.black
        sizeToFit()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(title: String) {
        self.init(frame: NSZeroRect)
        stringValue = title
        sizeToFit()
    }
    
    public class func descriptionLabel(fontSize: CGFloat, title: String = "") -> SKLabel {
        let label = SKLabel(title: title)
        label.makeAsDescriptionLabel(fontSize: fontSize)
        label.alignment = NSTextAlignment.center
        return label
    }
    
    public func makeAsDescriptionLabel(fontSize: CGFloat) {
        font = NSFont.monospacedDigitSystemFont(ofSize: fontSize, weight: NSFont.Weight.thin)
    }
    
}
