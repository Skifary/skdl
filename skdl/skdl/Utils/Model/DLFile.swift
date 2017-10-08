//
//  DLFile.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

fileprivate struct CoderKey {
    
    static let url = "skdl.file.key.url"
    static let name = "skdl.file.key.name"
    static let size = "skdl.file.key.size"
    static let duration = "skdl.file.key.duration"
    static let format = "skdl.file.key.format"
    static let ext = "skdl.file.key.ext"
    static let playlist = "skdl.file.key.playlist"
    static let local = "skdl.file.key.local"
    static let state = "skdl.file.key.state"
}

fileprivate typealias CK = CoderKey

class DLFile: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(url, forKey: CK.url)
        aCoder.encode(name, forKey: CK.name)
        aCoder.encode(size, forKey: CK.size)
        aCoder.encode(duration, forKey: CK.duration)
        aCoder.encode(format, forKey: CK.format)
        aCoder.encode(ext, forKey: CK.ext)
        aCoder.encode(playlist, forKey: CK.playlist)
        aCoder.encode(localFolder, forKey: CK.local)
        aCoder.encode(state.rawValue, forKey: CK.state)
    }
    
    required init?(coder aDecoder: NSCoder) {

        self.url = (aDecoder.decodeObject(forKey: CK.url) as? String) ?? ""
        self.name = (aDecoder.decodeObject(forKey: CK.name) as? String) ?? ""
        self.size = (aDecoder.decodeObject(forKey: CK.size) as? Int64) ?? 0
        self.duration = (aDecoder.decodeObject(forKey: CK.duration) as? Int64) ?? 0
        self.format = (aDecoder.decodeObject(forKey: CK.format) as? String) ?? ""
        self.ext = (aDecoder.decodeObject(forKey: CK.ext) as? String) ?? ""
        self.playlist = (aDecoder.decodeObject(forKey: CK.playlist) as? String) ?? ""
        self.localFolder = (aDecoder.decodeObject(forKey: CK.local) as? URL) ?? nil
        self.state = State(rawValue: (aDecoder.decodeObject(forKey: CK.state) as! Int16))!
    }
    

    init(url: URL? = nil) {
        
    }
    
    enum State: Int16 {
        case downloading
        case uncompleted
        case completed
    }
    
    var id: String? = ""
    
    var url: String? = ""
    
    var name: String? = ""
    
    var size: Int64? = 0
    
    var duration: Int64? = 0
    
    var format: String? = ""
    
    var ext: String? = ""
    
    var playlist: String? = ""
    
    var localFolder: URL? = nil
    
    var progress: String = "0.0%"
    
    var state: State = .uncompleted
    
    var task: DownloadTask?
    
    var sizeDescription: String {
        get {
           return FileSize.format(size: size)
        }
    }
    
    var tmpFilePath: URL {
        get {
            let url = localFolder?.appendingPathComponent("/" + id!, isDirectory: false)
            return url!
        }
    }
    
    var filePath: URL {
        get {
            let url = localFolder?.appendingPathComponent("/" + name! + "." + ext!, isDirectory: false)
            return url!
        }
    }
}
