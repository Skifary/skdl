//
//  SettingView.swift
//  skdl
//
//  Created by Skifary on 23/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class SettingView: NSView {
    
    fileprivate struct Text {
        
        static let SaveFolder = "保存路径："
        
    }

    fileprivate let saveFolderLabel: SKLabel = {
        let textField = SKLabel(title: Text.SaveFolder)
        textField.textColor = Color.NormalText
        return textField
    }()
    
    
    internal let chooseButton: NSButton = NSButton.button(with: ImageName.Choose)
    
    internal let advancedButton: NSButton = NSButton.button(with: ImageName.Advanced)
    
    internal let saveFolderPathLabel: SKLabel = {
        let textField = SKLabel(title: "")
        textField.textColor = NSColor.white
        return textField
    }()
    
    internal convenience init() {
        self.init(frame: NSZeroRect)
        
        setSubviews()
        
    }

    // 重写截获事件
    override func mouseDown(with event: NSEvent) {
        
    }
    
    fileprivate func setSubviews() {
        
        let views = [saveFolderLabel, chooseButton, saveFolderPathLabel, advancedButton]
        
        views.forEach { (v) in
            addSubview(v)
        }
        
        let size = saveFolderLabel.fittingSize
        
        saveFolderLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
            make.size.equalTo(size)
        }
        
        chooseButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.width.equalTo(18)
        }
        
        saveFolderPathLabel.snp.makeConstraints { (make) in
            make.left.equalTo(saveFolderLabel.snp.right)
           // make.right.equalTo(chooseButton.snp.right)
            make.height.equalTo(18)
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(PopoverView.Size.Content.width-16-size.width)
        }
        
        advancedButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(15.33)
            make.width.equalTo(18)
        }
        
    }
    
}
