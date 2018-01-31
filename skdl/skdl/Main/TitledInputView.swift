//
//  TitledInputView.swift
//  skdl
//
//  Created by Skifary on 26/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

let TitledInputViewDefaultTitle: String = "TITLEDINPUT"

class TitledInputView: InputView {
    
    //MARK:-

    fileprivate let lineLayer: ShadowLayer = ShadowLayer(with: Color.Basic.LightBlue.cgColor, 1.5)
    
    let titleLabel: SKLabel = {
        let label = SKLabel(title: TitledInputViewDefaultTitle)
        label.font = NSFont.systemFont(ofSize: 12, weight: .thin)
        label.textColor = Color.Basic.Title
        return label
    }()
    
    fileprivate let inputTextField: NSTextField = {
        let textfield = NSTextField.framelessTextField()
        textfield.textColor = Color.URLInput.Input
        textfield.font = NSFont.systemFont(ofSize: 17, weight: .thin)
        return textfield
    }()
    
    // public
    
    override var frame: NSRect {
        didSet {
            updateFrame()
        }
    }
    
    var title: String {
        get {
            return titleLabel.stringValue
        }
        set {
            titleLabel.stringValue = newValue
            updateFrame()
        }
    }
    
    var isEditable: Bool {
        get {
            return inputTextField.isEditable
        }
        set {
            inputTextField.isEditable = newValue
        }
    }
    
    var stringValue: String {
        get {
            return inputTextField.stringValue
        }
        set {
            inputTextField.stringValue = newValue
        }
    }
    
    //MARK:-
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        wantsLayer = true
        layer?.addSublayer(lineLayer)
        addSubviews([titleLabel, inputTextField])
        updateFrame()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateFrame() {
        
        lineLayer.frame = NSMakeRect(5, 0, lineLayer.cornerRadius * 2, frame.height)
        titleLabel.sizeToFit()
        titleLabel.frame = NSMakeRect(lineLayer.frame.maxX + 8, frame.height - titleLabel.frame.height, titleLabel.frame.width, titleLabel.frame.height)
        
        inputTextField.frame = NSMakeRect(titleLabel.frame.minX, 0, frame.width - lineLayer.frame.maxX - 4, 22)
    }
    
}
