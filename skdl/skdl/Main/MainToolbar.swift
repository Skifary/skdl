//
//  MainToolbar.swift
//  skdl
//
//  Created by Skifary on 26/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa


internal class MainToolbar: NSToolbar {

    override init(identifier: NSToolbar.Identifier) {
        super.init(identifier: identifier)

        self.displayMode = .labelOnly
    
    }
    
}

