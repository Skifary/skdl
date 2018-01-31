//
//  GeneralSettingView.swift
//  skdl
//
//  Created by Skifary on 28/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

func generalTitleLabel(_ title: String) -> SKLabel {
    let label = SKLabel(title: title)
    
    label.font = NSFont.systemFont(ofSize: 13, weight: .thin)
    label.textColor = Color.Basic.Title
    
    return label
}

class GeneralSettingView: BasicView {
    
    //MARK:-
    
    fileprivate let folderLabel: SKLabel = generalTitleLabel("Folder")
    
    fileprivate let extensionLabel:  SKLabel = generalTitleLabel("Extension")
    
    //public
    
    let folderInput: TitledInputView = {
        let input = TitledInputView(frame: NSZeroRect)
        input.title = "Local Folder"
        return input
    }()
    
    let chooseFolderButton: NSButton = NSButton.button(with: ImageName.General.ChooseFolder)
    
    let googleExtensionButton: NSButton = {
        let image = NSImage.image(with: "Google Extension", fontSize: 18, color: Color.Basic.LightBlue)
        let button = NSButton.button(with: image)
        button.frame = NSMakeRect(0, 0, image.size.width, image.size.height)
        return button
    }()
    
    //MARK:-
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubviews([folderLabel, folderInput, extensionLabel, googleExtensionButton, chooseFolderButton])
        layoutSubviews()
         titleLabel.stringValue = "GENERAL"
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutSubviews() {
        
        folderLabel.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(AppSize.Height * 0.1)
            make.height.equalTo(16)
            make.right.equalToSuperview().offset(-32)
        }
 
        folderInput.snp.makeConstraints { (make) in
            make.top.equalTo(folderLabel.snp.bottom).offset(12)
            make.height.equalTo(40)
            make.left.equalTo(folderLabel).offset(4)
            // -32 - 25 -8
            make.right.equalToSuperview().offset(-65)
        }
        
        chooseFolderButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(folderInput)
            make.height.width.equalTo(25)
            make.right.equalToSuperview().offset(-32)
        }
        
        extensionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(folderInput.snp.bottom).offset(32)
            make.height.equalTo(16)
            make.left.equalTo(folderLabel)
            make.right.equalToSuperview().offset(-32)
        }
        
        googleExtensionButton.snp.makeConstraints { (make) in
            make.top.equalTo(extensionLabel.snp.bottom).offset(12)
            make.left.equalTo(extensionLabel).offset(8)
            // make sure is ok
            make.height.equalTo(googleExtensionButton.frame.height)
            make.width.equalTo(googleExtensionButton.frame.width)
        }
    }
}
