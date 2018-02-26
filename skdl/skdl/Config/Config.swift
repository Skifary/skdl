//
//  Config.swift
//  skdl
//
//  Created by Skifary on 06/02/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Foundation

class Config {
    
    //MARK:-
    
    internal static let shared = Config()

    fileprivate init() {
        let path = Bundle.main.path(forResource: "config", ofType: ".plist")
        configs = NSMutableDictionary(contentsOfFile: path!)!
    }
    
    //MARK:-
    
    fileprivate var configs: NSMutableDictionary
    
    var copyright: String {
        return configs["copyright"] as! String
    }
    
    var rules: [String] {
        set {
            configs["rule"] = newValue
        }
        get {
            return configs["rule"] as! [String]
        }
    }
    
    //MARK:-
    
    func save() {
        configs.write(toFile: Bundle.main.path(forResource: "config", ofType: ".plist")!, atomically: true)
    }
    
}
