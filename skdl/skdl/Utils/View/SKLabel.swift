//
//  SKLabel.swift
//  skdl
//
//  Created by Skifary on 19/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate let defaultTitle = "Label"

class SKLabel: NSTextField {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.isEditable = false
        self.isBordered = false
        
        self.stringValue = defaultTitle
        
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: NSRect.zero)
    }
    
    class func descriptionLabel(fontSize: CGFloat) -> SKLabel {
        
        let label = SKLabel(frame: NSRect.zero)
        label.makeAsDescriptionLabel(fontSize: fontSize)
        return label
    }
    
    func makeAsDescriptionLabel(fontSize: CGFloat) {
        font = NSFont.monospacedDigitSystemFont(ofSize: fontSize, weight: NSFont.Weight.thin)
    }
    
}
