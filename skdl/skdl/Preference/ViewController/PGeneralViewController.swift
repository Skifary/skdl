//
//  PGeneralViewController.swift
//  skdl
//
//  Created by Skifary on 10/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class PGeneralViewController: NSViewController, MASPreferencesViewController {
    
    
    var viewIdentifier: String {
        get {
            return "general"
        }
        set {
            self.viewIdentifier = newValue
        }
    }

    override var nibName: NSNib.Name? {
        get {
            return NSNib.Name("PGeneralViewController")
        }
    }
    
    var toolbarItemLabel: String? {
        get {
            return "General"
        }
    }
    
    var toolbarItemImage: NSImage? {
        get {
            return NSImage(named: NSImage.Name.preferencesGeneral)!
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

