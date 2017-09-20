//
//  MessageAlert.swift
//  skdl
//
//  Created by Skifary on 13/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


class MessageAlert {
    
    static func show(title: String, message: String) {
        
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message;
        alert.alertStyle = .warning
        alert.runModal()
    }
    
}
