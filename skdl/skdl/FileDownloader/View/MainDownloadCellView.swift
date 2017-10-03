//
//  MainDownloadCellView.swift
//  skdl
//
//  Created by Skifary on 18/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

/* mdcv: main download cell view */
let MDCVIdentifier = "com.skifary.skdl.MDCVIdentifier"

fileprivate struct Constant {
    
    static let nameLabelTitle = "name"
    static let sizeLabelTitle = "000.00Kib"
    static let progressLabelTitle = "00.00%"
    static let etaLabelTitle = "00:00:00"
    static let speedLabelTitle = "000.00Kib/s"
    
    static let continueImageName = "download_continue"
    static let pauseImageName = "download_pause"
}

fileprivate typealias C = Constant

class MainDownloadCellView: NSTableCellView {

    let nameLabel = SKLabel(title: C.nameLabelTitle)
    
    let sizeLabel = SKLabel.descriptionLabel(fontSize: 13, title: C.sizeLabelTitle)
    
    let progressLabel = SKLabel.descriptionLabel(fontSize: 13, title: C.progressLabelTitle)
    
    let etaLabel = SKLabel.descriptionLabel(fontSize: 13, title: C.etaLabelTitle)
    
    let speedLabel = SKLabel.descriptionLabel(fontSize: 13, title: C.speedLabelTitle)
    
    let pauseButton: NSButton = {
        let button = NSButton()
        button.bezelStyle = NSButton.BezelStyle.circular
        button.title = ""
        button.image = NSImage(named: NSImage.Name(rawValue: C.pauseImageName))
        button.isBordered = false
        button.imageScaling = NSImageScaling.scaleProportionallyDown
        return button
    }()
    
    let horizontalLine: NSBox = {
        let line = NSBox()
        line.borderType = NSBorderType.grooveBorder
        line.boxType = NSBox.BoxType.separator
        line.fillColor = NSColor.gray
        return line
    }()
    
   // weak var task: DownloadTask?
    weak var file: DLFile?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        setSubview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviewLayout() {
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-8)
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
            make.width.equalTo(79)
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
    
    func setSubview() {
        
        let views = [nameLabel, sizeLabel, progressLabel, etaLabel, speedLabel, horizontalLine, pauseButton]
        for view in views {
            addSubview(view)
        }
        
        setSubviewLayout()
        
    }
    
    func addButton(target: AnyObject?, selector: Selector?) {
        pauseButton.target = target
        pauseButton.action = selector
    }
    
//    func setButtonImage(isDownloading: Bool) {
//        self.pauseButton.image = NSImage(named: NSImage.Name(isDownloading ? C.pauseImageName : C.continueImageName))
//    }
    
    func setButtonImage(state: DLFile.State) {
        self.pauseButton.image = NSImage(named: NSImage.Name(state == DLFile.State.downloading ? C.pauseImageName : C.continueImageName))
    }
}
