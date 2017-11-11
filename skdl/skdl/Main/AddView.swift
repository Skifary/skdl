//
//  AddView.swift
//  skdl
//
//  Created by Skifary on 22/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class AddView: NSView {
    
    fileprivate struct Text {

        static let URLPlaceHolder = "please input url"
        
    }
    


    internal let downloadButton: NSButton = NSButton.button(with: ImageName.Download)
    
    internal let urlTextField: NSTextField = {
        
        let textField = NSTextField(frame: NSZeroRect)
        
        textField.placeholderString = Text.URLPlaceHolder
        textField.drawsBackground = false
        textField.isBordered = false
        textField.focusRingType = .none
        textField.textColor = Color.NormalText
        
        return textField
    }()
    
    internal let errorLabel: SKLabel = {
        let label = SKLabel.descriptionLabel(fontSize: 12, title: "")
        
        label.textColor = Color.Error
        label.lineBreakMode = .byTruncatingTail
        label.alignment = .left
        label.isHidden = true
        
        return label
    }()
    
    
    internal let urlImageView: NSImageView = NSImageView(image: NSImage(named: ImageName.Link)!)
    
    internal let line: NSView = {
        let line = NSView(frame: NSZeroRect)
        line.wantsLayer = true
        line.layer?.backgroundColor = CGColor.white
        return line
    }()
    
    internal convenience init() {
        self.init(frame: NSZeroRect)
        
        setSubviews()
    }
    
    // 重写截获事件
    override func mouseDown(with event: NSEvent) {
        
    }
    
    internal func setSubviews() {
        
        let views = [urlTextField, downloadButton, line, urlImageView, errorLabel]

        views.forEach { (v) in
            addSubview(v)
        }
        
        urlImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(11)
            make.height.equalTo(12)
            make.width.equalTo(12)
        }
        
        // 这里发现了一个bug 当我设置约束的时候 会有点问题
        // 具体描述是 当我给left 和 right 同时添加向内(相对)的offset的时候 会导致整体UI变形
        // 除了这两个 其他没有发现问题
        urlTextField.snp.makeConstraints { (make) in
            
            // bug栗子 先留着
//            make.left.equalToSuperview().offset(8)
//            make.top.equalToSuperview().offset(8)
//            make.right.equalToSuperview().offset(-8)
//            make.height.equalTo(20)
            
            make.left.equalTo(urlImageView.snp.right).offset(4)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(20)
            make.width.equalTo(PopoverView.Size.Content.width - 38)
        }
        
        line.snp.makeConstraints { (make) in
            make.top.equalTo(urlTextField.snp.bottom)
            make.left.equalToSuperview().offset(6)
            make.height.equalTo(0.5)
            make.width.equalTo(PopoverView.Size.Content.width - 12)
        }
        
        downloadButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-8)
            make.width.equalTo(16)
            make.height.equalTo(14.75)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(line.snp.left)
            make.top.equalTo(line.snp.bottom).offset(4)
            make.height.equalTo(14)
            make.width.equalTo(PopoverView.Size.Content.width - 38)
        }
        
    }
    
    
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        
        guard let responser = window?.firstResponder else {
            Log.log("first responsder is nil")
            return false
        }
        
        guard responser.isKind(of: NSTextView.self) else {
            Log.log("first responsder is not a NSTextView")
            return false
        }
        
        guard event.type == .keyDown && event.modifierFlags.contains(.command) else {
            Log.log("modifierFlags is not contains command")
            return false;
        }
        
        let textView = responser as! NSTextView
        
        if event.keyCode == 0 {
            // command + a
            textView.selectAll(self)
        } else if event.keyCode == 6 {
            // command + z
            textView.undoManager?.undo()
        } else if event.keyCode == 7 {
            // command + x
            textView.cut(self)
        } else if event.keyCode == 8 {
            // command + c
            textView.copy(self)
        } else if event.keyCode == 9 {
            // command + v
            textView.paste(self)
        }
        return true
    }
    
    //MARK:-
    
    internal func showError(with error: String) {
        
        errorLabel.stringValue = error
        
        if errorLabel.isHidden {
            errorLabel.isHidden = false
        }
 
    }
    
    internal func hideError() {
        errorLabel.stringValue = ""
        
        if !errorLabel.isHidden {
            errorLabel.isHidden = true
        }

    }
    
}
