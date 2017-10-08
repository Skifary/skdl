//
//  Preference.swift
//  skdl
//
//  Created by Skifary on 11/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

typealias PK = Preference.Key
typealias PV = Preference.Value
let standardUD = UserDefaults.standard
let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]


struct Preference {
    
    static let defaultPreference:[String : Any] = [
        Key.localStorageFolder : docDir,
        Key.historyStorageFolders : [docDir],
        Key.defaultPlayer : "",
    ]
    
    struct Key {
        
        static let localStorageFolder = "localStorageFolder"
        
        static let historyStorageFolders = "historyStorageFolders"
        
        static let defaultPlayer = "defaultPlayer"
    }
    
    
    struct Value {
        static var localStoragePath: String? {
            get {
                return standardUD.string(forKey: Key.localStorageFolder)
            }
        }
        static func saveLocalStoragePath(path: String) {
            standardUD.set(path, forKey: Key.localStorageFolder)
        }
        
        static var historyStoragePaths: [String]? {
            get {
                return standardUD.stringArray(forKey: Key.historyStorageFolders)
            }
        }
        
        static func appendHistoryPath(path: String) {
            if (historyStoragePaths?.contains(path))! {
                return
            }
            var hsp = historyStoragePaths
            if hsp?.count == 10 {
                hsp?.remove(at: 9)
            }
            hsp?.insert(path, at: 0)
            standardUD.set(hsp, forKey: Key.historyStorageFolders)
        }
        
        static var defaultPlayer: String? {
            get {
                return standardUD.string(forKey: Key.defaultPlayer)
            }
        }
        
        static func setDefaultPlayer(name: String) {
             standardUD.set(name, forKey: Key.defaultPlayer)
        }
        
    }
    

    
}
