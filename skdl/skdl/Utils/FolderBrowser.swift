//
//  FolderBrowser.swift
//  skdl
//
//  Created by Skifary on 10/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation



class FolderBrowser {
    
    static func chooseFolder(title: String?) -> String? {
        let panel = NSOpenPanel()
        panel.title = title
        panel.canCreateDirectories = true
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.resolvesAliases = true
        panel.allowsMultipleSelection = false
        if panel.runModal().rawValue == NSFileHandlingPanelOKButton {
            let urlstring = panel.url?.absoluteString
            let lower = (urlstring?.index((urlstring?.startIndex)!, offsetBy: 7))!
            let upper = (urlstring?.index((urlstring?.endIndex)!, offsetBy: -1))!
            return String(urlstring![lower..<upper])
        }
        return nil
    }
}
