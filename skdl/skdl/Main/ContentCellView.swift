//
//  ContentCellView.swift
//  skdl
//
//  Created by Skifary on 08/11/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa



internal class ContentCellView: NSTableCellView {
    
 
    internal struct Size {
        internal static let Height: CGFloat = 50
        
        fileprivate static let PauseButton: CGFloat = 20
        
    }
    
    internal weak var video: Video!
    
    internal let thumbnailView: NSImageView = NSImageView(image: NSImage(named: ImageName.Default)!)

    internal let nameLabel: SKLabel = {
        let textField = SKLabel(title: "")
        
        textField.font = NSFont.systemFont(ofSize: 11)
        textField.textColor = NSColor.white
        
        textField.lineBreakMode = .byTruncatingTail
        
        return textField
    }()
    
    internal let sizeLabel: SKLabel = {
        let textField = SKLabel.descriptionLabel(fontSize: 10, title: "888.88MiB")
        textField.textColor = NSColor.white
        textField.alignment = NSTextAlignment.left
        return textField
    }()
    
    internal let progressLabel: SKLabel = {
        let textField = SKLabel.descriptionLabel(fontSize: 10, title: "88.88%")
        textField.textColor = NSColor.white
        return textField
    }()
    
    internal let speedLabel: SKLabel = {
        let textField = SKLabel.descriptionLabel(fontSize: 10, title: "888.88MiB/s")
        textField.textColor = NSColor.white
        return textField
    }()
    
    internal let etaLabel: SKLabel = {
        let textField = SKLabel.descriptionLabel(fontSize: 10, title: "88:88:88")
        textField.textColor = NSColor.white
        return textField
    }()
    
    internal let pauseButton: NSButton = NSButton.button(with: ImageName.Pause)
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        setSubviews()
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setSubviews() {
        
        addSubviews([thumbnailView, nameLabel, sizeLabel, progressLabel, pauseButton, etaLabel, speedLabel])
        
        thumbnailView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(ContentCellView.Size.Height - 16)
        }
        
        pauseButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(Size.PauseButton)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(thumbnailView.snp.right).offset(8)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(13)
            make.width.equalTo(AppSize.Content.width - 28 - 50 - ContentCellView.Size.Height - Size.PauseButton)
        }
        
        sizeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(thumbnailView.snp.right).offset(8)
            make.bottom.equalTo(thumbnailView.snp.bottom)
            make.height.equalTo(12)
            make.width.equalTo(54)
        }
        
        progressLabel.snp.makeConstraints { (make) in
            make.right.equalTo(pauseButton.snp.left).offset(-4)
            make.bottom.equalTo(sizeLabel.snp.bottom)
            make.height.equalTo(12)
            make.width.equalTo(42)
        }
        
        etaLabel.snp.makeConstraints { (make) in
            make.right.equalTo(pauseButton.snp.left).offset(-4)
            make.centerY.equalTo(nameLabel)
            make.height.equalTo(12)
            make.width.equalTo(50)
        }
        
        speedLabel.snp.makeConstraints { (make) in
            make.right.equalTo(progressLabel.snp.left)
            make.bottom.equalTo(progressLabel.snp.bottom)
            make.height.equalTo(12)
            make.width.equalTo(70)
        }
        
    }
    
    
    //MARK:-
    
    internal func setButtonImage(state: Video.State) {
        
        pauseButton.image = NSImage(named: state == Video.State.downloading ? ImageName.Pause : ImageName.Continue)
        
    }
    
}
