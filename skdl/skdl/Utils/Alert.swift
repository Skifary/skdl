//
//  Alert.swift
//  skdl
//
//  Created by Skifary on 13/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

public class Alert {
    
    public static func warn(_ title: String, _ message: String) {
        show(with: title, message, .warning)
    }
    
    public static func inform(_ title: String, _ message: String) {
        show(with: title, message, .informational)
    }
    
    public static func criticize(_ title: String, _ message: String) {
        show(with: title, message, .critical)
    }
    
    fileprivate static func show(with title:String, _ message: String, _ style: NSAlert.Style ) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message;
        alert.alertStyle = style
        alert.runModal()
        
    }
    
}




