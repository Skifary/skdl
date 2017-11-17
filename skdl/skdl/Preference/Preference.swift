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
        Key.localStorageFolder : docDir + "/skdl",
        Key.historyStorageFolders : [docDir],
        Key.defaultPlayer : "",
        Key.proxyType : 0,
        Key.proxyAddress : "127.0.0.1",
        Key.proxtPort : "1080",
        Key.socketTimeout : "5",
    ]
    
    struct Key {
        
        static let localStorageFolder = "localStorageFolder"
        
        static let historyStorageFolders = "historyStorageFolders"
        
        static let defaultPlayer = "defaultPlayer"
        
        static let proxyType = "proxyType"
        
        static let proxyAddress = "proxyAddress"
        
        static let proxtPort = "proxtPort"
        
        static let socketTimeout = "socketTimeout"
    }
    
    
    struct Value {
        static var localStoragePath: String? {
            set {
                standardUD.set(newValue, forKey: Key.localStorageFolder)
            }
            get {
                return standardUD.string(forKey: Key.localStorageFolder)
            }
        }

        static var historyStoragePaths: [String]? {
            return standardUD.stringArray(forKey: Key.historyStorageFolders)
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
            set {
                standardUD.set(newValue, forKey: Key.defaultPlayer)
            }
            get {
                return standardUD.string(forKey: Key.defaultPlayer)
            }
        }
        
        static var proxyType: Int? {
            set {
                standardUD.set(newValue, forKey: Key.proxyType)
            }
            get {
                return standardUD.integer(forKey: Key.proxyType)
            }
        }
        
        static var proxyAddress: String? {
            set {
                standardUD.set(newValue, forKey: Key.proxyAddress)
            }
            get {
                return standardUD.string(forKey: Key.proxyAddress)
            }
        }
        
        static var proxyPort: String? {
            set {
                standardUD.set(newValue, forKey: Key.proxtPort)
            }
            get {
                return standardUD.string(forKey: Key.proxtPort)
            }
        }
        
        static var socketTimeout: String? {
            set {
                standardUD.set(newValue, forKey: Key.socketTimeout)
            }
            get {
                return standardUD.string(forKey: Key.socketTimeout)
            }
        }
        
    }
    
    static var proxy: String {
        let proxyType = Value.proxyType == 0 ? "socks5" : "http"
        let address = Value.proxyAddress
        let port = Value.proxyPort
        
        let proxy: String = "\(proxyType)://\(address!):\(port!)/"
        return proxy
    }
    
}
