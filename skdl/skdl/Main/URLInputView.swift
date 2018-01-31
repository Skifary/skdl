//
//  URLInputView.swift
//  skdl
//
//  Created by Skifary on 26/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

fileprivate let URLTextFieldHeight: CGFloat = 24

let URLInputViewDefaultTitle: String = "URL"

class URLInputView: InputView {
    
    //MARK:- property

    fileprivate let urlTextField: NSTextField = {
        let textfield = NSTextField.framelessTextField()
        
        textfield.alignment = .center
        textfield.textColor = Color.URLInput.Input
        textfield.font = NSFont.systemFont(ofSize: 15, weight: .thin)
        
        return textfield
    }()
    
    fileprivate let titleLabel: SKLabel = {
        let label = SKLabel(title: "")
        label.font = NSFont.systemFont(ofSize: 13, weight: .thin)
        label.textColor = Color.URLInput.Title
        return label
    }()
    
    // public
    
    var lineColor: NSColor = Color.Basic.LightBlue
    
    var urlString: String {
        get {
            return urlTextField.stringValue
        }
    }

    override var frame: NSRect {
        didSet {
            updateFrame()
        }
    }
    
    //MARK:-
    
    convenience init(frame frameRect: NSRect, title: String = URLInputViewDefaultTitle) {
        self.init(frame: frameRect)
        titleLabel.stringValue = title
        titleLabel.sizeToFit()
        addSubviews([urlTextField, titleLabel])
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSGraphicsContext.saveGraphicsState()

        // bottom line
        let path = NSBezierPath()
        path.move(to: NSPoint.zero)
        path.line(to: NSMakePoint(frame.width, 0))
        path.lineWidth = 5
        lineColor.set()
        path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    fileprivate func updateFrame() {
        
        titleLabel.frame.origin = NSMakePoint(0, frame.height - titleLabel.frame.height)
 
        urlTextField.frame = NSMakeRect(0, titleLabel.frame.origin.y - URLTextFieldHeight - 4, frame.width, URLTextFieldHeight)
    }
    
}
