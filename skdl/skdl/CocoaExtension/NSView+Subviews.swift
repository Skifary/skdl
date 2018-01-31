//
//  NSView+Subviews.swift
//  skdl
//
//  Created by Skifary on 24/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

extension NSView {
    
    // add subview array
    public func addSubviews(_ subviews: [NSView]) {
        subviews.forEach { (view) in
            addSubview(view)
        }
    }
    
}
