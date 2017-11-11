//
//  ContentTableView.swift
//  skdl
//
//  Created by Skifary on 08/11/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate let ColumnIdentifier = "com.skifary.skdl.contenttableviewcolumnidentifier"

internal class ContentTableView: NSTableView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(ColumnIdentifier))
        
        addTableColumn(column)
        headerView = nil
        backgroundColor = NSColor.clear
        refusesFirstResponder = true
        
        selectionHighlightStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
