//
//  OfflineVideoManagerCellView.swift
//  skdl
//
//  Created by Skifary on 07/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa



fileprivate struct DefaultValue {
    
    static let Name = "name"
    static let Size = "000.00KiB"
    
}

fileprivate let LocalPlayButtonImageName = "local_play"

internal class OfflineVideoManagerCellView: NSTableCellView {

    internal weak var video: Video!
    
    internal let nameLabel = SKLabel(title: DefaultValue.Name)
    
    internal let sizeLabel = SKLabel.descriptionLabel(fontSize: 13, title: DefaultValue.Size)
    
    internal let playButton = NSButton.button(with: NSImage(named: NSImage.Name(rawValue: LocalPlayButtonImageName)))
    
    internal let showInTheFinderButton = NSButton.button(with: NSImage(named: NSImage.Name.folder))
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        setSubview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setSubviewLayout() {
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-108)
            make.height.equalTo(17)
        }
        
        sizeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(17)
            make.width.equalTo(71)
        }
        
        showInTheFinderButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.right.equalToSuperview().offset(-8)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.right.equalTo(showInTheFinderButton.snp.left).offset(-8)
        }
        
    }
    
    fileprivate func setSubview() {
        
        let views = [nameLabel, sizeLabel, playButton, showInTheFinderButton]
        for view in views {
            addSubview(view)
        }
        setSubviewLayout()
    }
    
    internal func set(with video: Video) {
        nameLabel.stringValue = video.name
        sizeLabel.stringValue = video.sizeDescription
    }
    
    internal func addPlayButton(target: AnyObject?, action: Selector?) {
        playButton.target = target
        playButton.action = action
    }
    
    internal func addShowInTheFinderButton(target: AnyObject?, action: Selector?) {
        showInTheFinderButton.target = target
        showInTheFinderButton.action = action
    }
    
}
