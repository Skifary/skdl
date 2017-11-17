//
//  Video.swift
//  skdl
//
//  Created by Skifary on 06/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class Video: NSObject, NSCoding {
    
    //MARK:- NSCoder Key
    fileprivate struct CoderKey {
        static let url = "skdl.video.key.url"
        static let name = "skdl.video.key.name"
        static let size = "skdl.video.key.size"
        static let duration = "skdl.video.key.duration"
        static let format = "skdl.video.key.format"
        static let ext = "skdl.video.key.ext"
        static let playlist = "skdl.video.key.playlist"
        static let local = "skdl.video.key.local"
        static let state = "skdl.video.key.state"
        static let isProxy = "skdl.video.key.isProxy"
    }
    
    internal func encode(with aCoder: NSCoder) {
        aCoder.encode(url, forKey: CoderKey.url)
        aCoder.encode(name, forKey: CoderKey.name)
        aCoder.encode(size, forKey: CoderKey.size)
        aCoder.encode(duration, forKey: CoderKey.duration)
        aCoder.encode(format, forKey: CoderKey.format)
        aCoder.encode(ext, forKey: CoderKey.ext)
        aCoder.encode(playlist, forKey: CoderKey.playlist)
        aCoder.encode(localFolder, forKey: CoderKey.local)
        aCoder.encode(state.rawValue, forKey: CoderKey.state)
        aCoder.encode(needProxy, forKey: CoderKey.isProxy)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        url = (aDecoder.decodeObject(forKey: CoderKey.url) as? String) ?? ""
        name = (aDecoder.decodeObject(forKey: CoderKey.name) as? String) ?? ""
        size = (aDecoder.decodeObject(forKey: CoderKey.size) as? Int64) ?? 0
        duration = (aDecoder.decodeObject(forKey: CoderKey.duration) as? Int64) ?? 0
        format = (aDecoder.decodeObject(forKey: CoderKey.format) as? String) ?? ""
        ext = (aDecoder.decodeObject(forKey: CoderKey.ext) as? String) ?? ""
        playlist = (aDecoder.decodeObject(forKey: CoderKey.playlist) as? String) ?? ""
        localFolder = (aDecoder.decodeObject(forKey: CoderKey.local) as? URL) ?? nil
        state = State(rawValue: (aDecoder.decodeObject(forKey: CoderKey.state) as! Int16))!
        needProxy = aDecoder.decodeBool(forKey: CoderKey.isProxy)
    }
    
    override init() {
        
    }
    
    internal enum State: Int16 {
        case downloading
        case online
        case offline
    }
    
    // unique id
    internal var id: String = ""

    internal var url: String = ""
    
    internal var name: String = ""
    
    internal var size: Int64 = 0
    
    internal var duration: Int64 = 0
    
    // video format
    internal var format: String = ""
    
    internal var ext: String = ""
    
    internal var playlist: String = ""
    
    internal var localFolder: URL?
    
    internal var progress: String = "0.0%"
    
    internal var state: State = .online
    
    internal var task: DownloadTask?
    
    internal var needProxy: Bool = false
    
    internal var sizeDescription: String {
        return FileSize.format(size: size)
    }
    
    internal var downloadPath: URL? {
        guard let url = localFolder else {
            Log.logWithCallStack("local folder is nil")
            return nil
        }
        return url.appendingPathComponent("/" + id, isDirectory: false)
    }
    
    internal var filePath: URL? {
        guard let url = localFolder else {
            Log.logWithCallStack("local folder is nil")
            return nil
        }
        return url.appendingPathComponent("/" + name + "." + ext, isDirectory: false)
    }
}
