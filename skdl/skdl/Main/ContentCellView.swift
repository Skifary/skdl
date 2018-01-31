//
//  ContentCellView.swift
//  skdl
//
//  Created by Skifary on 08/11/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class ContentCellView: NSTableCellView {
    
    static func descriptionLabel(with title: String) -> SKLabel {
        let label = SKLabel(title: title)
        label.textColor = Color.MainDesc
        label.font = NSFont.systemFont(ofSize: 10, weight: .thin)
        return label
    }
    
    //MARK:-
    
    internal weak var video: Video!

    internal let nameLabel: SKLabel = {
        let textField = SKLabel(title: "")
        
        textField.font = NSFont.systemFont(ofSize: 14, weight: .thin)
        textField.textColor = NSColor.white
        
        textField.lineBreakMode = .byTruncatingTail
        
        return textField
    }()
    
    internal let progressLabel: SKLabel = {
        let label = descriptionLabel(with: "88.88%")
        label.alignment = .left
        return label
    }()
    
    internal let speedLabel: SKLabel = {
        let label = descriptionLabel(with: "888.88MiB/s")
        label.alignment = .right
        return label
    }()
    
    internal let pauseButton: NSButton = NSButton.button(with: ImageName.Pause)
    
    //MARK:-
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        setSubviews()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setSubviews() {
        
        addSubviews([nameLabel, progressLabel, pauseButton, speedLabel])
        
        let buttonSize: CGFloat = 20
        
        pauseButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(buttonSize)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(17)
            make.right.equalTo(pauseButton.snp.left).offset(-8)
        }
        
        progressLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.height.equalTo(12)
            make.width.equalTo(100)
        }
        
        speedLabel.snp.makeConstraints { (make) in
            make.right.equalTo(pauseButton.snp.left).offset(-8)
            make.bottom.equalTo(progressLabel.snp.bottom)
            make.height.equalTo(12)
            make.width.equalTo(100)
        }

    }
    
    //MARK:-
    
    internal func setButtonImage(state: Video.State) {
        pauseButton.image = NSImage(named: state == Video.State.downloading ? ImageName.Pause : ImageName.Continue)
    }
    
}
