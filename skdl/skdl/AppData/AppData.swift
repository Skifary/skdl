//
//  AppData.swift
//  skdl
//
//  Created by Skifary on 04/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


internal struct AppData {
    
   
    internal static let HistoryFileName = "history.plist"
    
    internal static let PreferenceTitle = ""
    
}

internal struct AppSize {
    
    internal static let Content = NSMakeSize(320, 568)
    
    static var Height: CGFloat {
        return AppSize.Content.height
    }
    
    static var Width: CGFloat {
        return AppSize.Content.width
    }
    
}
