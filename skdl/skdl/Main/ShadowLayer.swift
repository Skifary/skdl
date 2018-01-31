//
//  ShadowLayer.swift
//  skdl
//
//  Created by Skifary on 27/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class ShadowLayer: CALayer {
    
    convenience init(with backgroundColor: CGColor, _ cornerRadius: CGFloat) {
        self.init()
        self.backgroundColor = backgroundColor
        shadowColor = backgroundColor
        shadowOpacity = 0.5
        self.cornerRadius = cornerRadius
    }
    
}

