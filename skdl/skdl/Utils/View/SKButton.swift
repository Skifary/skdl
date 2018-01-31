//
//  SKButton.swift
//  skdl
//
//  Created by Skifary on 25/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

open class SKButton: NSButton {
    
    public struct TwinkleOption: OptionSet {

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public var rawValue: Int = 0
        
        public static var border: TwinkleOption = TwinkleOption(rawValue: 1 << 0)
        public static var background: TwinkleOption = TwinkleOption(rawValue: 1 << 1)
        
    }

    public enum TwinkleType {
        case shadow
        case light
    }
    
    open var twinkleLevel: CGFloat = 0.1
    
    open var twinkleOption: TwinkleOption = [.border, .background]
    
    open var twinkleType: TwinkleType = .shadow
    
    fileprivate var textLayer: CATextLayer = CATextLayer()
    
    open var textColor: NSColor = NSColor.black
    
    open var backgroundColor: NSColor = NSColor.clear
    
    open var borderColor: NSColor = NSColor.clear
    
    open var borderWidth: CGFloat = 0.0 {
        didSet {
            layer?.borderWidth = borderWidth
        }
    }
    
    open var cornerRadius: CGFloat = 1.0 {
        didSet {
            layer?.cornerRadius = cornerRadius
        }
    }
    
    override open var title: String {
        didSet(newValue) {
            setTextColor(newValue, newColor: textColor)
        }
    }
    
    convenience init(_ text: String, textColor: NSColor = NSColor.black, backgroundColor: NSColor = NSColor.white, borderColor: NSColor = NSColor.black) {
        self.init(frame: NSZeroRect)
        
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        title = text
    }
    
    private override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        setup()
    }
    
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        wantsLayer = true

        layer?.cornerRadius = 3
        layer?.borderWidth = 1
        
        layer?.borderColor = borderColor.cgColor
        layer?.backgroundColor = backgroundColor.cgColor
        
        setButtonType(NSButton.ButtonType.momentaryLight)
        
        return
    }
    
    override open var wantsUpdateLayer: Bool {
        return true
    }
    
    override open func updateLayer() {
        if isHighlighted {
            
            if twinkleOption.contains(.border) {
                layer?.borderColor = twinkleType == .shadow ? borderColor.shadow(withLevel: twinkleLevel)?.cgColor : borderColor.highlight(withLevel: twinkleLevel)?.cgColor
            }
            
            if twinkleOption.contains(.background) {
                layer?.backgroundColor = twinkleType == .shadow ? backgroundColor.shadow(withLevel: twinkleLevel)?.cgColor : backgroundColor.highlight(withLevel: twinkleLevel)?.cgColor
            }
            
        } else {
            layer?.backgroundColor = backgroundColor.cgColor
            layer?.borderColor = borderColor.cgColor
        }
    }
    
    fileprivate func setTextColor(_ text: String, newColor: NSColor) {
        let attrTitle = NSMutableAttributedString(attributedString: attributedTitle)
        let range = NSMakeRange(0, title.characters.count)
        attrTitle.addAttributes([NSAttributedStringKey.foregroundColor: newColor], range: range)
        attributedTitle = attrTitle
    }
    
}
