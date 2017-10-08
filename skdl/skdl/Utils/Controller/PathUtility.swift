//
//  PathUtility.swift
//  skdl
//
//  Created by Skifary on 04/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


class PathUtility {
    
    static func createDirIfNotExist(url: URL) {
        let path = url.path
        // check exist
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print(error.localizedDescription)
                MessageAlert.fatal("Cannot create folder in Application Support directory")
            }
        }
    }
    
    static let appSupportDirURL: URL = {
        // get path
        let asPath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        MessageAlert.assert(asPath.count >= 1, "Cannot get path to Application Support directory")
        let bundleID = Bundle.main.bundleIdentifier!
        let appAsUrl = asPath.first!.appendingPathComponent(bundleID)
        createDirIfNotExist(url: appAsUrl)
        return appAsUrl
    }()
    
    static func deleteFileIfExist(url: URL) {
        let path = url.path
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                MessageAlert.fatal("Cannot delete file in Application Support directory")
            }
        }
    }
    
    static func renameFileIfExist(old: URL, new: URL) {
        if FileManager.default.fileExists(atPath: old.path) {
            do {
                try FileManager.default.moveItem(at: old, to: new)
            } catch {
                print(error.localizedDescription)
                MessageAlert.fatal("Cannot rename file")
            }
        }
    }

    static func getURLFromString(_ urlString: String) -> URL {
        let allowedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        return URL(string: allowedString!)!
    }
    
}
