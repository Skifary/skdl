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
    
    fileprivate let extensionLabel: SKLabel = generalTitleLabel("Extension")
    
    fileprivate let ytdlLabel: SKLabel = generalTitleLabel("Youtube-dl")
    
    fileprivate let useLocalYTDLCheckBox: CheckBoxView = CheckBoxView(frame: NSRect.zero)
    
    fileprivate let automaticUpdateYTDLCheckBox: CheckBoxView = CheckBoxView(frame: NSRect.zero)
    
    fileprivate let logLabel: SKLabel = generalTitleLabel("Log")
    
    fileprivate let ytdlVersionLabel: SKLabel = {
        let label = SKLabel(title: "Version : ")
        label.font = NSFont.systemFont(ofSize: 11, weight: .thin)
        label.textColor = Color.CheckBox.LightGray
        return label
    }()

    let folderInput: TitledInputView = {
        let input = TitledInputView(frame: NSZeroRect)
        input.title = "Local Folder"
        return input
    }()
    
    let chooseFolderButton: NSButton = NSButton.button(with: ImageName.General.ChooseFolder)
    
    let googleExtensionButton: NSButton = NSButton.button(with: "Google Extension", fontSize: 18, color: Color.Basic.LightBlue)
    
    let openLogFolderButton: NSButton = NSButton.button(with: "Open Log Folder", fontSize: 18, color: Color.Basic.LightBlue)
    
    let clearLogsButton: NSButton = NSButton.button(with: "Clear Logs", fontSize: 18, color: Color.Basic.LightBlue)
    
    var isUseLocalYTDL: Bool {
        set {
            useLocalYTDLCheckBox.isChecked = newValue
        }
        get {
            return useLocalYTDLCheckBox.isChecked
        }
    }
    
    var isAutomaticUpdateYTDL: Bool {
        set {
            automaticUpdateYTDLCheckBox.isChecked = newValue
        }
        get {
            return automaticUpdateYTDLCheckBox.isChecked
        }
    }
    
    let updateYTDLButton: NSButton = NSButton.button(with: "Update youtube-dl", fontSize: 18, color: Color.Basic.LightBlue)
    
    //MARK:-
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubviews([folderLabel, folderInput, extensionLabel, googleExtensionButton, chooseFolderButton, ytdlLabel, useLocalYTDLCheckBox, automaticUpdateYTDLCheckBox, updateYTDLButton, logLabel, openLogFolderButton, clearLogsButton, ytdlVersionLabel])
        layoutSubviews()
        titleLabel.stringValue = "GENERAL"
        
        useLocalYTDLCheckBox.title = "Use local youtube-dl"
        automaticUpdateYTDLCheckBox.title = "Automatic update"
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutSubviews() {
        
        let sectionOffset = 24
        
        let itemOffset = 12
        
        folderLabel.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(AppSize.Height * 0.1)
            make.height.equalTo(18)
            make.right.equalToSuperview().offset(-24)
        }
 
        folderInput.snp.makeConstraints { (make) in
            make.top.equalTo(folderLabel.snp.bottom).offset(itemOffset)
            make.height.equalTo(40)
            make.left.equalTo(folderLabel).offset(4)
            // -24 - 25 -8
            make.right.equalToSuperview().offset(-57)
        }
        
        chooseFolderButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(folderInput)
            make.height.width.equalTo(25)
            make.right.equalToSuperview().offset(-24)
        }
        
        ytdlLabel.snp.makeConstraints { (make) in
            make.top.equalTo(folderInput.snp.bottom).offset(sectionOffset)
            make.height.equalTo(18)
            make.left.equalTo(folderLabel)
            make.right.equalTo(folderLabel)
        }
        
        useLocalYTDLCheckBox.snp.makeConstraints { (make) in
            make.top.equalTo(ytdlLabel.snp.bottom).offset(itemOffset)
            make.left.equalTo(ytdlLabel).offset(16)
            make.height.equalTo(16)
            make.right.equalTo(ytdlLabel)
        }
        
        automaticUpdateYTDLCheckBox.snp.makeConstraints { (make) in
            make.top.equalTo(useLocalYTDLCheckBox.snp.bottom).offset(itemOffset)
            make.left.equalTo(useLocalYTDLCheckBox)
            make.height.equalTo(16)
            make.right.equalTo(ytdlLabel)
        }
        
        ytdlVersionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(automaticUpdateYTDLCheckBox.snp.bottom).offset(itemOffset)
            make.left.right.equalTo(automaticUpdateYTDLCheckBox)
            make.height.equalTo(16)
        }
        
        updateYTDLButton.snp.makeConstraints { (make) in
            make.top.equalTo(ytdlVersionLabel.snp.bottom).offset(itemOffset)
            make.left.equalTo(ytdlVersionLabel)
            // make sure is ok
            make.height.equalTo(updateYTDLButton.frame.height)
            make.width.equalTo(updateYTDLButton.frame.width)
        }
        
        extensionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(updateYTDLButton.snp.bottom).offset(sectionOffset)
            make.height.equalTo(16)
            make.left.equalTo(folderLabel)
            make.right.equalTo(ytdlLabel)
        }
        
        googleExtensionButton.snp.makeConstraints { (make) in
            make.top.equalTo(extensionLabel.snp.bottom).offset(itemOffset)
            make.left.equalTo(extensionLabel).offset(16)
            // make sure is ok
            make.height.equalTo(googleExtensionButton.frame.height)
            make.width.equalTo(googleExtensionButton.frame.width)
        }

        logLabel.snp.makeConstraints { (make) in
            make.top.equalTo(googleExtensionButton.snp.bottom).offset(sectionOffset)
            make.left.equalTo(ytdlLabel)
            make.right.equalTo(ytdlLabel)
            make.height.equalTo(18)
        }
        
        openLogFolderButton.snp.makeConstraints { (make) in
            make.top.equalTo(logLabel.snp.bottom).offset(itemOffset)
            make.left.equalTo(logLabel).offset(16)
            // make sure is ok
            make.height.equalTo(openLogFolderButton.frame.height)
            make.width.equalTo(openLogFolderButton.frame.width)
        }
        
        clearLogsButton.snp.makeConstraints { (make) in
            make.top.equalTo(openLogFolderButton.snp.bottom).offset(itemOffset)
            make.left.equalTo(openLogFolderButton)
            // make sure is ok
            make.height.equalTo(clearLogsButton.frame.height)
            make.width.equalTo(clearLogsButton.frame.width)
        }

    }
    
    func setVersion(_ version: String?) {
        
        guard let version = version else { return }
        ytdlVersionLabel.stringValue = "Version : " + version
    }
}
