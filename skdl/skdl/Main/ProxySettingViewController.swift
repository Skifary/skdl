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
        
        proxySettingView.okTitle = "Save"
        
        let proxy = Proxy()
        proxySettingView.method = proxy.method.rawValue
        proxySettingView.address = proxy.address
        proxySettingView.port = proxy.port
        
        proxySettingView.rules = rules()
        
    }
    
    override func okAction(_ sender: NSButton) {
        
        let rules = proxySettingView.rules.split(separator: "\n")
        
        Config.shared.rules.removeAll()
        for index in 0..<rules.count {
            
            if rules[index].first == "#" {
                continue
            }
            
            Config.shared.rules.append(String(rules[index]))
        }
        
        Config.shared.save()
        Proxy.save(ProxyMethod(rawValue: proxySettingView.method)!, proxySettingView.address, proxySettingView.port)
        super.okAction(sender)
    }
    
    fileprivate func rules() -> String {
        var rules = "#custom rules\n#use sharp(#) for comment\n#eg:www.youtube-dl.com\n"
        
        Config.shared.rules.forEach { (rule) in
            rules += rule + "\n"
        }
        return rules
    }
    
}
