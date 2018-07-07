//
//  BasicView.swift
//  skdl
//
//  Created by Skifary on 06/12/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class BasicView: NSView {
    
    //MARK:-
    
    let backButton: NSButton = NSButton.button(with: ImageName.Basic.Back)

    let titleLabel: SKLabel = {
        let label = SKLabel(title: "TITLE")
        label.alignment = .center
        label.textColor = Color.Basic.LightBlue
        label.font = NSFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    let okButton: NSButton = NSButton.button(with: "OK", fontSize: 25, color: Color.Basic.LightBlue)
    
    var okTitle: String = "OK" {
        didSet {
        
            let image = NSImage.image(with: okTitle, fontSize: 25, color: Color.Basic.LightBlue)
            okButton.image = image
            updateOKButtonFrame(with: image.size)
        }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubviews([backButton, titleLabel, okButton])
        
        layoutBasicView()
        
        wantsLayer = true
        layer?.backgroundColor = CGColor.white
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-
    
    fileprivate func layoutBasicView() {
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(24)
            make.width.height.equalTo(11)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(backButton.snp.right).offset(8)
            // right offset 11 + 24 + 8
            make.right.equalToSuperview().offset(-43)
            make.height.equalTo(22)
            make.centerY.equalTo(backButton)
        }
        
        okButton.snp.makeConstraints { (make) in
            
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-32)
            // make sure is ok
            make.height.equalTo(okButton.frame.height)
            make.width.equalTo(okButton.frame.width)
        }
        
    }
    
    fileprivate func updateOKButtonFrame(with newSize: NSSize) {
        
        okButton.snp.updateConstraints { (make) in
            make.height.equalTo(newSize.height)
            make.width.equalTo(newSize.width)
        }
        
    }
    
}
