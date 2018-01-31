//
//  ProxySettingViewController.swift
//  skdl
//
//  Created by Skifary on 27/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class ProxySettingViewController: BasicViewController {

    //MARK:-
    
    var proxySettingView: ProxySettingView {
        return view as! ProxySettingView
    }
    
    override func loadView() {
        view = ProxySettingView(frame: NSZeroRect)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proxySettingView.okTitle = "SAVE"
        
        let proxy = Proxy()
        proxySettingView.type = proxy.type
        proxySettingView.address = proxy.address
        proxySettingView.port = proxy.port
    }
    
    
    override func okAction(_ sender: NSButton) {
        
        Proxy.save(proxySettingView.type, proxySettingView.address, proxySettingView.port)
        super.okAction(sender)
    }
    
}
