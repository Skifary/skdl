//
//  ProxyView.swift
//  skdl
//
//  Created by Skifary on 11/11/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class ProxyView: NSView {

    fileprivate struct Title {
        
        static let ProxyType = "Proxy Type:"
        
        static let Sock5 = "Sock5"
        
        static let HTTP = "HTTP"
        
        static let Address = "Address:"
        
        static let Port = "Port:"
        
        static let Main = "Porxy Setting"
        
    }

    internal let TitleLabel: SKLabel = {
        let label = SKLabel(title: Title.Main)
        label.alignment = .center
        return label
    }()
    
    internal let proxyTypeLabel: SKLabel = {
        let label = SKLabel(title: Title.ProxyType)
        label.alignment = .right
        return label
    }()
    
    // 这里如果使用self self没有初始化 会造成设置无效
    // 这里不用他的text  会造成一个透明的效果 不知道是如何产生的
    internal let sock5CheckBox: NSButton = {
        let button = NSButton(checkboxWithTitle: "", target: nil, action: nil)
        button.imagePosition = .imageOnly
        return button
    }()
    internal let sock5CheckBoxLabel: SKLabel = SKLabel(title: Title.Sock5)
    
    internal let httpCheckBox: NSButton = {
        let button = NSButton(checkboxWithTitle: "", target: nil, action: nil)
        button.imagePosition = .imageOnly
        return button
    }()
    internal let httpCheckBoxLabel: SKLabel = SKLabel(title: Title.HTTP)
    
    internal let addressLabel: SKLabel = {
        let label = SKLabel(title: Title.Address)
        label.alignment = .right
        return label
    }()
    internal let addressTextField: NSTextField = {
        
        let textField = NSTextField(frame: NSZeroRect)

        textField.focusRingType = .none

        return textField
    }()
    
    internal let portLabel: SKLabel = {
        let label = SKLabel(title: Title.Port)
        label.alignment = .right
        return label
    }()
    internal let portTextField: NSTextField = {
        
        let textField = NSTextField(frame: NSZeroRect)

        textField.focusRingType = .none
        
        return textField
    }()
    
    internal let backgroundView: NSView = NSView(frame: NSZeroRect)
    
    fileprivate var hideEvent: (()->Void)?
    
    //MARK:- check box action
    
    @objc fileprivate func sock5CheckBoxAction(_ sender: NSButton) {
        sock5CheckBox.state = .on
        httpCheckBox.state = .off
    }
    
    @objc fileprivate func httpCheckBoxAction(_ sender: NSButton) {
        httpCheckBox.state = .on
        sock5CheckBox.state = .off
    }
    
    //MARK:- init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: NSZeroRect)

        wantsLayer = true
        layer?.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        setSubviews()
    
        setCheckBox()
    }
    
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextFieldNextKeyView() {
        
        addressTextField.nextKeyView = portTextField
        portTextField.nextKeyView = addressTextField
    }
    
    fileprivate func setCheckBox() {
        
        setProxyType(with: PV.proxyType!)
     
        sock5CheckBox.target = self
        sock5CheckBox.action = #selector(sock5CheckBoxAction)
        
        httpCheckBox.target = self
        httpCheckBox.action = #selector(httpCheckBoxAction)
    }

    fileprivate func setSubviews() {
    
        addSubview(backgroundView)
        
        backgroundView.wantsLayer = true
        backgroundView.layer?.backgroundColor = CGColor.white
        
        backgroundView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(PopoverView.Size.Content.height / 2)
        }
        
        let views = [TitleLabel, proxyTypeLabel, sock5CheckBox, sock5CheckBoxLabel, httpCheckBox, httpCheckBoxLabel, addressLabel, addressTextField, portLabel, portTextField]
        
        views.forEach { (v) in
            backgroundView.addSubview(v)
        }
        
        TitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
            make.width.equalTo(PopoverView.Size.Content.width - 16)
        }
        
        proxyTypeLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(TitleLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(8)
            make.width.equalTo(PopoverView.Size.Content.width/3 - 8)
            make.height.equalTo(18)
        }
        
        sock5CheckBox.snp.makeConstraints { (make) in
            make.left.equalTo(proxyTypeLabel.snp.right).offset(8)
            make.centerY.equalTo(proxyTypeLabel)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        sock5CheckBoxLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sock5CheckBox.snp.right).offset(2)
            make.centerY.equalTo(sock5CheckBox)
            make.height.equalTo(sock5CheckBox.snp.height)
            make.width.equalTo(50)
        }
        
        httpCheckBox.snp.makeConstraints { (make) in
            make.left.equalTo(sock5CheckBoxLabel.snp.right).offset(8)
            make.centerY.equalTo(sock5CheckBox)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        httpCheckBoxLabel.snp.makeConstraints { (make) in
            make.left.equalTo(httpCheckBox.snp.right).offset(2)
            make.centerY.equalTo(httpCheckBox)
            make.height.equalTo(httpCheckBox.snp.height)
            make.width.equalTo(50)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(proxyTypeLabel)
            make.top.equalTo(proxyTypeLabel.snp.bottom).offset(16)
            make.width.equalTo(proxyTypeLabel.snp.width)
            make.height.equalTo(proxyTypeLabel.snp.height)
        }
        
        addressTextField.snp.makeConstraints { (make) in
            make.left.equalTo(addressLabel.snp.right).offset(8)
            make.centerY.equalTo(addressLabel)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        portLabel.snp.makeConstraints { (make) in
            make.left.equalTo(addressLabel)
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.width.equalTo(addressLabel.snp.width)
            make.height.equalTo(addressLabel.snp.height)
        }
        
        portTextField.snp.makeConstraints { (make) in
            make.left.equalTo(portLabel.snp.right).offset(8)
            make.centerY.equalTo(portLabel)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
    
        //然后写返回事件
        
        // 然后添加 如果不可用 使用代理的逻辑
    }
    
    //MARK:- event
    
    override func mouseDown(with event: NSEvent) {
        
        let localLocation = convert(event.locationInWindow, from: nil)
        
        guard !backgroundView.frame.contains(localLocation) else {
            return
        }

        hideEvent!()
        
    }
        
    
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        
        print(event.keyCode)
        
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
    }
    
    
    //MARK:-
    
    internal func registerForHideEvent( block: @escaping () -> Void) {
        hideEvent = block
    }
    
    internal func setProxyType(with type: Int) {
        if type == 0 {
            sock5CheckBox.state = .on
            httpCheckBox.state = .off
        } else {
            sock5CheckBox.state = .off
            httpCheckBox.state = .on
        }
    }
    
    internal func proxyType() -> Int {
        if sock5CheckBox.state == .on {
            return 0
        }
        return 1
    }
    
}
