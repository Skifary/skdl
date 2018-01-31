//
//  InputView.swift
//  skdl
//
//  Created by Skifary on 27/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class InputView: NSView {
    
    //MARK:- key board
    
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        
        guard let responser = window?.firstResponder else {
            return false
        }
        
        guard responser.isKind(of: NSTextView.self) else {
            return false
        }
        
        guard event.type == .keyDown && event.modifierFlags.contains(.command) else {
            return false;
        }
        
        let textView = responser as! NSTextView

        if event.keyCode == 0 {
            // command + a
            textView.selectAll(self)
        } else if event.keyCode == 6 {
            // command + z
            textView.undoManager?.undo()
        } else if event.keyCode == 7 {
            // command + x
            textView.cut(self)
        } else if event.keyCode == 8 {
            // command + c
            textView.copy(self)
        } else if event.keyCode == 9 {
            // command + v
            textView.paste(self)
        }
        return true
    }
    
}
