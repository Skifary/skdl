//
//  PGeneralViewController.swift
//  skdl
//
//  Created by Skifary on 10/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class PGeneralViewController: NSViewController, MASPreferencesViewController {

    override var nibName: String? {
        get {
            return "PGeneralViewController"
        }
    }
    
    // need to override
    override var identifier: String? {
        get {
            return "general"
        }
        set {
            super.identifier = newValue
        }
    }
    
    
    
    var toolbarItemLabel: String? {
        get {
            return "General"
        }
    }
    
    var toolbarItemImage: NSImage? {
        get {
            return NSImage(named: NSImageNamePreferencesGeneral)!
        }
    }
    
    @IBOutlet weak var pathLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    
    
    @IBAction func choosePath(_ sender: Any) {
        
    }
    
}

