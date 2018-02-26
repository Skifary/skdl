//
//  ProxySettingView.swift
//  skdl
//
//  Created by Skifary on 27/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

struct Proxy {
    
    var type: Int = PV.proxyType ?? 0
    
    var address: String = PV.proxyAddress ?? ""
    
    var port: String = PV.proxyPort ?? ""
    
    static func save(_ type: Int, _ address: String, _ port: String) {
        
        PV.proxyType = type
        
        PV.proxyAddress = address
        
        PV.proxyPort = port
    }
    
}

class ProxySettingView: BasicView {

    //MARK:-
    
    fileprivate let proxySegment: SegmentControl = SegmentControl(["HTTP", "SOCKS"], frameRect: NSZeroRect)
    
    fileprivate let addressInput: TitledInputView = {
        let input = TitledInputView(frame: NSZeroRect)
        input.title = "Address"
        return input
    }()
 
    fileprivate let portInput: TitledInputView = {
        let input = TitledInputView(frame: NSZeroRect)
        input.title = "Port"
        return input
    }()
    
    fileprivate let filterLabel: SKLabel = generalTitleLabel("Rule")
    
    fileprivate let ruleTextView: RuleTextView = RuleTextView()
    
    // public
    
    var type: Int {
        get {
            return proxySegment.currentIndex
        }
        set {
            proxySegment.currentIndex = newValue
        }
    }
    
    var address: String {
        get {
            return addressInput.stringValue
        }
        set {
            addressInput.stringValue = newValue
        }
    }
    
    var port: String {
        get {
            return portInput.stringValue
        }
        set {
            portInput.stringValue = newValue
        }
    }
    
    var rules: String {
        get {
            return ruleTextView.textView.string
        }
        set {
            ruleTextView.textView.string = newValue
        }
    }
    
    //MARK:-
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubviews([proxySegment, addressInput, portInput, filterLabel, ruleTextView])
        layoutSubviews()
        
        titleLabel.stringValue = "PROXY"
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutSubviews() {
        
        proxySegment.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(AppSize.Height * 0.15)
            make.height.equalTo(25)
            make.width.equalTo(150)
        }
        
        addressInput.snp.makeConstraints { (make) in
            make.top.equalTo(proxySegment.snp.bottom).offset(24)
            make.height.equalTo(40)
            make.left.equalTo(proxySegment)
            make.right.equalToSuperview().offset(-32)
        }
        
        portInput.snp.makeConstraints { (make) in
            make.top.equalTo(addressInput.snp.bottom).offset(24)
            make.height.equalTo(40)
            make.left.equalTo(addressInput)
            make.right.equalTo(addressInput)
        }
        
        filterLabel.sizeToFit()
        filterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(portInput.snp.bottom).offset(32)
            make.left.equalTo(portInput)
            make.height.equalTo(filterLabel.frame.height)
            make.width.equalTo(filterLabel.frame.width)
        }
        
        ruleTextView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.top.equalTo(filterLabel.snp.bottom).offset(4)
            make.bottom.equalTo(okButton.snp.top).offset(-32)
        }
        
    }
    
}
