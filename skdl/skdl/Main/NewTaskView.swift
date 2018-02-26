//
//  NewTaskView.swift
//  skdl
//
//  Created by Skifary on 26/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class NewTaskView: BasicView {

    //MARK:-
    
    fileprivate let urlInputView: URLInputView = URLInputView(frame: NSRect.zero, title: URLInputViewDefaultTitle)
    
    fileprivate let useProxyCheckBox: CheckBoxView = CheckBoxView(frame: NSRect.zero)
    
    // public
    
    var url: String {
        get {
            return urlInputView.urlString
        }
    }
    
    var isUseProxy: Bool {
        get {
            return useProxyCheckBox.isChecked
        }
    }
    
    //MARK:-
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubviews([urlInputView, useProxyCheckBox])
        layoutSubviews()
        titleLabel.stringValue = "NEW TASK"
        useProxyCheckBox.title = "Use proxy"
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutSubviews() {
        
        urlInputView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.top.equalToSuperview().offset(AppSize.Height * 0.15)
            make.height.equalTo(50)
        }
        
        useProxyCheckBox.snp.makeConstraints { (make) in
            make.top.equalTo(urlInputView.snp.bottom).offset(36)
            make.height.equalTo(16)
            make.left.equalTo(urlInputView)
            make.right.equalTo(urlInputView)
        }
        
    }
    
}
