//
//  Color.swift
//  skdl
//
//  Created by Skifary on 17/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa


internal struct Color {
    
    internal static let Main = color(with: 0x262932, alpha: 0.8)
    
    internal static let MainDesc = color(with: 0xBBBDC3)

    internal struct Basic {
        
        internal static let Title = color(with: 0x4B4F63, alpha: 0.59)
        
         internal static let LightBlue = color(with: 0x4A90E2)
    }
    
    internal struct CheckBox {
        internal static let LightGray = color(with: 0x818C9E)
    }
    
    internal struct URLInput {
        
        internal static let Title = color(with: 0x818C9E)
        
        internal static let Input = color(with: 0x5B6473)
    }
    
    internal struct TitledInput {

        internal static let Input = color(with: 0x4B4F63)
        
    }
    
    internal struct SegmentControl {
        internal static let Unselected = color(with: 0x818C9E)
    }
    
}

func color(with hex: uint32, alpha: CGFloat = 1.0) -> NSColor {
    let red = CGFloat((hex >> 16) & 0xFF) / 255.0
    let green = CGFloat((hex >> 8) & 0xFF) / 255.0
    let blue = CGFloat((hex) & 0xFF) / 255.0
    return NSColor(red: red, green: green, blue: blue, alpha: alpha)
}

