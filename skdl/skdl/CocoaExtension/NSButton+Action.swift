//
//  NSButton+Action.swift
//  skdl
//
//  Created by Skifary on 31/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

extension NSButton {
    
    func add(_ action: Selector?, _ delegate: AnyObject) {
        self.action = action
        target = delegate
    }
    
    static func batchAddActions(_ actionInfo: [NSButton : Selector?], _ delegate: AnyObject) {
        actionInfo.forEach { (button, action) in
            button.add(action, delegate)
        }
    }
    
}

