//
//  Draw.swift
//  skdl
//
//  Created by Skifary on 27/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

/// draw image
///
/// - Parameters:
///   - size: size
///   - useNSGraphicsContext: true if use NSGraphicsContext, default is false
///   - drawBlock: draw code
/// - Returns: image
func drawImageInNewCGContext(size: CGSize, useNSGraphicsContext: Bool = false, drawBlock: (_ context: CGContext) -> ()) -> NSImage {
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    let scaleFactor = NSScreen.main!.backingScaleFactor
    
    let context = CGContext(
        data: nil,
        width: Int(size.width * scaleFactor),
        height: Int(size.height * scaleFactor),
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: bitmapInfo.rawValue
    )
    
    if useNSGraphicsContext {
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(cgContext: context!, flipped: false)
    }
    
    drawBlock(context!)
    
    if useNSGraphicsContext {
        NSGraphicsContext.restoreGraphicsState()
    }
    
    let image = context!.makeImage()
    // 重点 cgimage的坐标原点在左上角
    let newImage = image?.cropping(to: NSMakeRect(0, size.height, size.width, size.height))
    
    return NSImage(cgImage: newImage!, size: NSMakeSize(size.width/scaleFactor, size.height/scaleFactor))
    
}
