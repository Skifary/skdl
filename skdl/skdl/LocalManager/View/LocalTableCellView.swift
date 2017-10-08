//
//  LocalTableCellView.swift
//  skdl
//
//  Created by Skifary on 07/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

/* LCV: local cell view */
let LCVIdentifier = "com.skifary.skdl.LCVIdentifier"

fileprivate struct Constant {
    
    static let nameLabelTitle = "name"
    static let sizeLabelTitle = "000.00KiB"
    
    static let localPlayButtonImage = "local_play"
    
}

fileprivate typealias C = Constant


class LocalTableCellView: NSTableCellView {

    weak var file: DLFile?
    
    let nameLabel = SKLabel(title: C.nameLabelTitle)
    
    let sizeLabel = SKLabel.descriptionLabel(fontSize: 13, title: C.sizeLabelTitle)
    
    let playButton = NSButton.button(with: NSImage(named: NSImage.Name(rawValue: C.localPlayButtonImage)))
    
    let showInTheFinderButton = NSButton.button(with: NSImage(named: NSImage.Name.folder))
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
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
    
    func setSubview() {
        
        let views = [nameLabel, sizeLabel, playButton, showInTheFinderButton]
        for view in views {
            addSubview(view)
        }
        
        setSubviewLayout()
        
    }
    
    func set(with file: DLFile) {
        nameLabel.stringValue = file.name!
        sizeLabel.stringValue = file.sizeDescription
    }
    
    func addPlayButton(target: AnyObject?, action: Selector?) {
        playButton.target = target
        playButton.action = action
    }
    
    func addShowInTheFinderButton(target: AnyObject?, action: Selector?) {
        showInTheFinderButton.target = target
        showInTheFinderButton.action = action
    }
    
}
