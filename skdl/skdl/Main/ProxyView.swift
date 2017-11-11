//
//  ProxyView.swift
//  skdl
//
//  Created by Skifary on 11/11/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class ProxyView: NSView {

    fileprivate struct Text {
        
        static let ProxyTypeTitle = "sock5"
        
        
        
    }

    let returnButton = NSButton.button(with: ImageName.Return)
    
    let proxyTypeLabel = SKLabel(title: Text.ProxyTypeTitle)
    
    let addressTextField: NSTextField = {
        
        let textField = NSTextField(frame: NSZeroRect)
        
       // textField.placeholderString = Text.
        textField.drawsBackground = false
        textField.isBordered = false
        textField.focusRingType = .none
        textField.textColor = Color.NormalText
        
        return textField
    }()
    
    //MARK:- init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: NSZeroRect)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-
    
    
}
