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

//fileprivate struct Constant {
//    
//    static let nameTableColumnTitle = "名称"
//    
//}
//
//fileprivate typealias C = Constant

class MainDownloadCellView: NSTableCellView {

    
    let nameLabel = SKLabel()
    
    let sizeLabel = SKLabel.descriptionLabel(fontSize: 13)
    
    let progressLabel = SKLabel.descriptionLabel(fontSize: 13)
    
    let etaLabel = SKLabel.descriptionLabel(fontSize: 13)
    
    let speedLabel = SKLabel.descriptionLabel(fontSize: 13)
    
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
            make.left.top.equalToSuperview().offset(8)
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
            make.width.equalTo(57)
        }
        
    }
    
    func setSubview() {
        
        let views = [nameLabel, sizeLabel, progressLabel, etaLabel, speedLabel]
        for view in views {
            addSubview(view)
        }
        
        setSubviewLayout()
        
    }
    
}
