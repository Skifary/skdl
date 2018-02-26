//
//  CheckBoxView.swift
//  skdl
//
//  Created by Skifary on 24/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

let CheckBoxViewDefaultTitle: String = "CHECKBOX"

class CheckBoxView: NSView {
    
    typealias CheckChangeHandle = () -> ()
    
    //MARK:- property
    
    // private
    fileprivate let checkButton: NSButton = NSButton.button(with: ImageName.CheckBox.Unchecked)
    
    fileprivate let label: SKLabel = {
        let label = SKLabel(title: CheckBoxViewDefaultTitle)
        label.font = NSFont.systemFont(ofSize: 11, weight: .thin)
        label.textColor = Color.CheckBox.LightGray
        return label
    }()
    
    // public

    var isChecked: Bool = false {
        didSet {
            updateCheckButton(isChecked)
        }
    }
    
    var title: String {
        get {
            return label.stringValue
        }
        set {
            label.stringValue = newValue
            updateFrame()
        }
    }
    
    var font: NSFont? {
        get {
            return label.font
        }
        set {
            label.font = newValue
            updateFrame()
        }
    }
    
    var isEnable: Bool {
        get {
            return checkButton.isEnabled
        }
        set {
           checkButton.isEnabled = newValue
        }
    }
    
    override var frame: NSRect {
        didSet {
            checkButton.frame = NSMakeRect(0, 0, frame.height, frame.height)
            updateFrame()
        }
    }
    
    //MARK:-
    
    func addStatusChangeHandle(_ action: CheckChangeHandle) {
        // waiting for s
    }
    
    //MARK:-
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        layoutSubviews()
        
        checkButton.add(#selector(checkAction), self)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutSubviews() {
        
        let subviews: [NSView] = [label, checkButton]
        addSubviews(subviews)
        checkButton.frame = NSMakeRect(0, 0, frame.height, frame.height)
        updateFrame()
    }
    
    @objc fileprivate func checkAction(_ sender: NSButton) {
        
//        if isChecked {
//            isChecked = false
//            checkButton.image = NSImage(named: ImageName.CheckBox.Unchecked)
//        } else {
//            isChecked = true
//            checkButton.image = NSImage(named: ImageName.CheckBox.Checked)
//        }
//
        isChecked = !isChecked
        updateCheckButton(isChecked)
    }
    
    fileprivate func updateCheckButton(_ status: Bool) {
        checkButton.image = status ? NSImage(named: ImageName.CheckBox.Checked) : NSImage(named: ImageName.CheckBox.Unchecked)
    }
    
    fileprivate func updateFrame() {
        label.sizeToFit()
        label.frame.origin = NSMakePoint(frame.height + 4, frame.height/2 - label.frame.height/2)
    }
    
}
