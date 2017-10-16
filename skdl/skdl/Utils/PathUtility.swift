//
//  PathUtility.swift
//  skdl
//
//  Created by Skifary on 04/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

public class PathUtility {
    
    public static func createDirectoryIfNotExist(url: URL) {
        let path = url.path
        // check exist
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
            } catch {
                Log.log(error.localizedDescription)
                ErrorReport.fatal("Cannot create folder in Application Support directory")
            }
        }
    }
    
    public static let appSupportDirectoryURL: URL = {
        // get path
        let asPath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        Assert.assert(asPath.count >= 1, "Cannot get path to Application Support directory")
        let bundleID = Bundle.main.bundleIdentifier!
        let appASURL = asPath.first!.appendingPathComponent(bundleID)
        createDirectoryIfNotExist(url: appASURL)
        return appASURL
    }()
    
    static func deleteFileIfExist(url: URL) {
        let path = url.path
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                Log.log(error.localizedDescription)
                ErrorReport.fatal("Cannot delete file in Application Support directory")
            }
        }
    }
    
    static func renameFileIfExist(old: URL, new: URL) {
        if FileManager.default.fileExists(atPath: old.path) {
            do {
                try FileManager.default.moveItem(at: old, to: new)
            } catch {
                Log.log(error.localizedDescription)
                ErrorReport.fatal("Cannot rename file")
            }
        }
    }

    
    // 不确定这个函数到底用了没 先留着
    
//    static func getURLFromString(_ urlString: String) -> URL {
//
//        guard let allowedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
//
//            Log.logWithCallStack("")
//
//            return URL(
//        }
//
//
//        return URL(string: allowedString)
//    }
    
}
