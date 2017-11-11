//
//  Color.swift
//  skdl
//
//  Created by Skifary on 17/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa


internal struct Color {
    
    internal static let Main = color(with: 0x6A2C70)
    
    internal static let Minor = color(with: 0xB83B5E)
    
    internal static let NormalText = color(with: 0xd7d7d9)
    
    internal static let Error = color(with: 0xF9ED69)
    
}

func color(with hex: uint32, alpha: CGFloat = 1.0) -> NSColor {
    let red = CGFloat((hex >> 16) & 0xFF) / 255.0
    let green = CGFloat((hex >> 8) & 0xFF) / 255.0
    let blue = CGFloat((hex) & 0xFF) / 255.0
    return NSColor(red: red, green: green, blue: blue, alpha: alpha)
}

