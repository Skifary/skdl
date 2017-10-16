//
//  OnlineVideoDownloaderCellView.swift
//  skdl
//
//  Created by Skifary on 18/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate struct DefaultValue {
    static let Name = "name"
    static let Size = "000.00KiB"
    static let Progress = "00.00%"
    static let Eta = "00:00:00"
    static let Speed = "000.00KiB/s"
}

fileprivate let ContinueImageName = "download_continue"
fileprivate let PauseImageName = "download_pause"

internal class MainDownloadCellView: NSTableCellView {

    internal let nameLabel = SKLabel(title: DefaultValue.Name)
    
    internal let sizeLabel = SKLabel.descriptionLabel(fontSize: 13, title: DefaultValue.Size)
    
    internal let progressLabel = SKLabel.descriptionLabel(fontSize: 13, title: DefaultValue.Progress)
    
    internal let etaLabel = SKLabel.descriptionLabel(fontSize: 13, title: DefaultValue.Eta)
    
    internal let speedLabel = SKLabel.descriptionLabel(fontSize: 13, title: DefaultValue.Speed)
    
    internal let pauseButton: NSButton = NSButton.button(with: NSImage(named: NSImage.Name(rawValue: PauseImageName)))
    
    internal let horizontalLine: NSBox = {
        let line = NSBox()
        line.borderType = NSBorderType.grooveBorder
        line.boxType = NSBox.BoxType.separator
        line.fillColor = NSColor.gray
        return line
    }()
    
    internal weak var video: Video!
    
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
        
        progressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.sizeLabel.snp.right).offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(17)
            make.width.equalTo(50)
        }
        
        etaLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.progressLabel.snp.right).offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(17)
            make.width.equalTo(61)
        }
        
        speedLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(17)
            make.width.equalTo(100)
        }
        
        horizontalLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        pauseButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(speedLabel)
            make.bottom.equalTo(speedLabel.snp.top).offset(-8)
            make.height.width.equalTo(20)
        }
        
    }
    
    fileprivate func setSubview() {
        let views = [nameLabel, sizeLabel, progressLabel, etaLabel, speedLabel, horizontalLine, pauseButton]
        for view in views {
            addSubview(view)
        }
        setSubviewLayout()
    }
    
    internal func addButton(target: AnyObject?, selector: Selector?) {
        pauseButton.target = target
        pauseButton.action = selector
    }
    
    internal func setButtonImage(state: Video.State) {
        self.pauseButton.image = NSImage(named: NSImage.Name(state == Video.State.downloading ? PauseImageName : ContinueImageName))
    }
}
