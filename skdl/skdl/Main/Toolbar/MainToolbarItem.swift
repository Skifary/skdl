//
//  MainToolbarItem.swift
//  skdl
//
//  Created by Skifary on 26/08/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

let kMainToolbarItemDownloaderIdentifier: String = "com.skdl.maintoolbaritem.downloader"
let kMainToolbarItemFileManagerIdentifier: String = "com.skdl.maintoolbaritem.filemanager"

let kMainToolbarItemDownloaderTitle: String = "下载"
let kMainToolbarItemFileManagerTitle: String = "已完成"


fileprivate struct Constant {
    //static
}

fileprivate typealias C = Constant

class MainToolbarItem: NSToolbarItem {
    
    override init(itemIdentifier: String) {
        super.init(itemIdentifier: itemIdentifier)
        
        
    }
    
}
