//
//  SegmentControl.swift
//  skdl
//
//  Created by Skifary on 26/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class SegmentControl: NSView {

    // 网易云的朋友/附近有一个挺有意思的实现
    
    //MARK:-
    
    // private
    
    fileprivate let selectedLayer: ShadowLayer = ShadowLayer(with: Color.Basic.LightBlue.cgColor, 0)
    
    fileprivate let selectedTextLayer: CATextLayer = CATextLayer()

    // public
    
    var currentIndex: Int = 0 {
        didSet {
            updateLayerFrame()
        }
    }
    
    var titles: [String] = []
    
    var borderColor: NSColor = Color.Basic.LightBlue
    
    var selectedColor: NSColor = Color.Basic.LightBlue
    
    var unselectedColor: NSColor = Color.SegmentControl.Unselected
    
    var fontSize: CGFloat = 13
    
    var selectedFontSize: CGFloat {
        get {
            return fontSize + 2
        }
    }
    
    var segmentCount: Int {
        get {
            return titles.count
        }
    }
    
    var segmentWidth: CGFloat {
        get {
            return realFrame().width / CGFloat(segmentCount)
        }
    }
    
    var currentStringValue: String {
        get {
            return titles[currentIndex]
        }
    }

    override var frame: NSRect {
        didSet {
            updateLayerFrame()
        }
    }
    
    //MARK:-
    
    convenience init(_ titles: [String], frameRect: NSRect) {
        self.init(frame: frameRect)
        
        self.titles = titles
        addSelectedLayer()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let newFrame = realFrame()
        NSGraphicsContext.saveGraphicsState()
        
        let width: CGFloat = segmentWidth
        
        for (index ,title) in titles.enumerated() {

            let nsTitle = NSString(string: title)
            let titleFrame = NSMakeRect(width * CGFloat(index), newFrame.minY, width, newFrame.height)

            let attributes = titleAttributes(fontSize, unselectedColor)
            
            let size = nsTitle.size(withAttributes: attributes)
            let origin = NSMakePoint((titleFrame.width - size.width)/2 + titleFrame.minX, (titleFrame.height - size.height)/2 + titleFrame.minY)
            
            nsTitle.draw(at: origin, withAttributes: attributes)
        }

        let path = NSBezierPath(roundedRect: newFrame, xRadius: frame.height / 2, yRadius: frame.height / 2)
        path.lineWidth = 1
        borderColor.set()
        path.stroke()
 
        NSGraphicsContext.restoreGraphicsState()
    }
    
    fileprivate func realFrame() -> NSRect {
        return NSMakeRect(1, 1, frame.width - 2, frame.height - 2)
    }
    
    fileprivate func addSelectedLayer() {
        wantsLayer = true
        layer?.addSublayer(selectedLayer)
        selectedLayer.addSublayer(selectedTextLayer)
        selectedTextLayer.contentsScale = (NSScreen.main?.backingScaleFactor)!
        selectedTextLayer.font = NSFont.systemFont(ofSize: fontSize, weight: .thin)
        selectedTextLayer.fontSize = selectedFontSize
        updateLayerFrame()
    }
    
    //MARK:-
    
    fileprivate func updateLayerFrame() {
        
        let newFrame = realFrame()
        selectedLayer.frame = NSMakeRect(newFrame.minX + segmentWidth * CGFloat(currentIndex), newFrame.minY, segmentWidth, newFrame.height)
        selectedLayer.cornerRadius = newFrame.height/2
        
        selectedTextLayer.string = currentStringValue
        let size = NSString(string: currentStringValue).size(withAttributes: titleAttributes(selectedFontSize, selectedColor))
        
        let x = (selectedLayer.frame.width - size.width)/2
        let y = (selectedLayer.frame.height - size.height)/2 - newFrame.minY
        
        selectedTextLayer.frame = NSMakeRect(x, y, size.width, size.height)

    }
    
    func titleAttributes(_ fontSize: CGFloat, _ color: NSColor) -> [NSAttributedStringKey : Any] {
        let font = NSFont.systemFont(ofSize: fontSize, weight: .thin)
        
        let attributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.font: font,
            NSAttributedStringKey.foregroundColor: color,
            ]
        return attributes
    }
    
    //MARK:-
    
    override func mouseDown(with event: NSEvent) {
        let location = convert(event.locationInWindow, from: nil)
        currentIndex = Int(location.x / segmentWidth)
        updateLayerFrame()
    }
    
}
