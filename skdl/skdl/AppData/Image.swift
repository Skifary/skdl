//
//  Image.swift
//  skdl
//
//  Created by Skifary on 11/11/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa


internal struct ImageName {
    
    //MARK:- status bar
    
    static let StatusBarIcon = NSImage.Name("statusbar_icon")
    
    //MARK:- popover
    static let Setting = NSImage.Name("popover_setting")
    
    static let Folder = NSImage.Name("popover_folder")
    
    static let NewTask = NSImage.Name("popover_add")
    
    //MARK:- cell
    static let Default = NSImage.Name("popover_content_defaultimage")
    
    static let Pause = NSImage.Name("download_pause")
    
    static let Continue = NSImage.Name("download_continue")
    
    //MARK:- basic
    
    struct Basic {
        static let Back = NSImage.Name("basic_back")
    }
    
    struct CheckBox {
     
        static let Checked = NSImage.Name("checkbox_checked")
    
        static let Unchecked = NSImage.Name("checkbox_unchecked")
    
    }
    
    struct General {
        
        static let ChooseFolder = NSImage.Name("general_choose_folder")
    }
    
    struct About {
        
        static let Logo = NSImage.Name("about_logo")
    }
    
    
}
