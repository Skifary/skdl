//
//  FolderBrowser.swift
//  skdl
//
//  Created by Skifary on 10/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

public class FolderBrowser {
    
    static func chooseFolder(title: String?) -> URL? {
        let panel = NSOpenPanel()
        panel.title = title
        panel.canCreateDirectories = true
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.resolvesAliases = true
        panel.allowsMultipleSelection = false
        if panel.runModal().rawValue == NSFileHandlingPanelOKButton {
            return panel.url
        }
        return nil
    }
    
    static func chooseFile(title: String?) -> URL? {
        let panel = NSOpenPanel()
        panel.title = title
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.resolvesAliases = false
        panel.allowsMultipleSelection = false
        if panel.runModal().rawValue == NSFileHandlingPanelOKButton {
            return panel.url
        }
        return nil
    }
    
}
