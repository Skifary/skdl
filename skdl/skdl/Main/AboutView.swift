//
//  AboutView.swift
//  skdl
//
//  Created by Skifary on 28/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class AboutView: NSView {
    
    let versionLabel: SKLabel = {
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        let label = SKLabel(title: "Version " + version)
        label.font = NSFont.systemFont(ofSize: 23, weight: .thin)
        label.textColor = Color.Basic.LightBlue
        
        return label
    }()
    
    let copyrightLabel: SKLabel = {
        let label = SKLabel(title: "Copyright © 2017-2018 Skifary.\nAll rights reserved.")
        label.alignment = .center
        label.font = NSFont.systemFont(ofSize: 13, weight: .thin)
        label.textColor = Color.Basic.Title
        return label
    }()
    
    let logoImageView: NSImageView = NSImageView(image: NSImage(named: ImageName.About.Logo)!)
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubviews([versionLabel, copyrightLabel, logoImageView])
        layoutSubviews()

        wantsLayer = true
        
        layer?.backgroundColor = CGColor.white
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutSubviews() {
        
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(AppSize.Height * 0.25)
            make.height.width.equalTo(100)
        }
        
        versionLabel.sizeToFit()
        versionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.height.equalTo(versionLabel.frame.height)
            make.width.equalTo(versionLabel.frame.width)
        }
        copyrightLabel.sizeToFit()
        copyrightLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
            make.height.equalTo(copyrightLabel.frame.height)
            make.width.equalTo(copyrightLabel.frame.width)
        }
    }

    override func mouseDown(with event: NSEvent) {
        let viewController = nextResponder as? NSViewController
        viewController?.dismiss(nil)
    }

}
