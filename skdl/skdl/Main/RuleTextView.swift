//
//  RuleTextView.swift
//  skdl
//
//  Created by Skifary on 03/02/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class RuleTextView: NSView {
    
    fileprivate static func filterView() -> NSScrollView {
        let scrollView = NSScrollView(frame: NSZeroRect)
        let textView = NSTextView(frame: NSMakeRect(0, 0, AppSize.Width - 64, 0))
        scrollView.documentView = textView
        
        textView.font = NSFont.systemFont(ofSize: 12, weight: .thin)
        textView.textColor = Color.TitledInput.Input

        textView.drawsBackground = false
        scrollView.drawsBackground = false
        return scrollView
    }
    
    var textView: NSTextView {
        return scollView.documentView as! NSTextView
    }
    
    fileprivate let scollView = filterView()

    override var frame: NSRect {
        didSet {
            scollView.frame = bounds
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubview(scollView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSGraphicsContext.saveGraphicsState()

        let path = NSBezierPath(roundedRect: bounds, xRadius: 8, yRadius: 8)
        path.lineWidth = 1
        color(with: 0x979797).set()
        path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()

    }
    
}
