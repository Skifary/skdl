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

enum ProxyMethod : Int {
    case HTTP = 0
    case SOCKS5 = 1
}

struct Preference {
    
    static let defaultPreference:[String : Any] = [
        Key.localStorageFolder : docDir + "/skdl",
        Key.historyStorageFolders : [docDir],
        Key.proxyMethod : ProxyMethod.HTTP.rawValue,
        Key.proxyAddress : "127.0.0.1",
        Key.proxtPort : "1080",
        Key.socketTimeout : "10",
        Key.useLocalYTDL : false,
        Key.automaticUpdateYTDL : true,
    ]
    
    struct Key {
        
        static let localStorageFolder = "localStorageFolder"
        
        static let historyStorageFolders = "historyStorageFolders"
        
        static let proxyMethod = "proxyMethod"
        
        static let proxyAddress = "proxyAddress"
        
        static let proxtPort = "proxtPort"
        
        static let socketTimeout = "socketTimeout"
        
        static let useLocalYTDL = "useLocalYoutubeDL"
        
        static let automaticUpdateYTDL = "automaticUpdateYTDL"
    }
    
    
    struct Value {
        static var localStoragePath: String! {
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

        static var proxyMethod: ProxyMethod? {
            set {
                standardUD.set(newValue?.rawValue, forKey: Key.proxyMethod)
            }
            get {
                return ProxyMethod(rawValue: standardUD.integer(forKey: Key.proxyMethod))
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
        
        static var socketTimeout: String! {
            set {
                standardUD.set(newValue, forKey: Key.socketTimeout)
            }
            get {
                return standardUD.string(forKey: Key.socketTimeout)
            }
        }
        
        static var useLocalYTDL: Bool {
            set {
                standardUD.set(newValue, forKey: Key.useLocalYTDL)
            }
            get {
                return standardUD.bool(forKey: Key.useLocalYTDL)
            }
        }
        
        static var automaticUpdateYTDL: Bool {
            set {
                standardUD.set(newValue, forKey: Key.automaticUpdateYTDL)
            }
            get {
                return standardUD.bool(forKey: Key.automaticUpdateYTDL)
            }
        }
        
    }
    
    static var proxy: String {
        let proxyType = Value.proxyMethod == ProxyMethod.HTTP ? "http" : "socks5"
        let address = Value.proxyAddress
        let port = Value.proxyPort
        
        let proxy: String = "\(proxyType)://\(address!):\(port!)/"
        return proxy
    }
    
}
