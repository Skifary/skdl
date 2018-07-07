//
//  PathUtility.swift
//  skdl
//
//  Created by Skifary on 04/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation
import Cocoa

public class PathUtility {
    
    public static func createDirectoryIfNotExist(url: URL) {
        createDirectoryIfNotExist(url.path)
    }
    
    public static func createDirectoryIfNotExist(_ path: String) {
        // check exist
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print("can't create folder, path is : \(path)")
                print(error.localizedDescription)
            }
        }
    }
    
    public static let appSupportDirectoryURL: URL = {
        // get path
        let asPath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        assert(asPath.count >= 1, "Cannot get path to Application Support directory")
        let bundleID = Bundle.main.bundleIdentifier!
        let appASURL = asPath.first!.appendingPathComponent(bundleID)
        createDirectoryIfNotExist(url: appASURL)
        return appASURL
    }()
    
    public static let cacheDirectoryURL: URL = {
        // get path
        let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        assert(cachePath.count >= 1, "Cannot get path to Application Support directory")
        let bundleID = Bundle.main.bundleIdentifier!
        let cacheURL = cachePath.first!.appendingPathComponent(bundleID)
        createDirectoryIfNotExist(url: cacheURL)
        return cacheURL
    }()

    static func deleteFileIfExist(url: URL) {
        deleteFileIfExist(url.path)
    }
    
    static func deleteFileIfExist(_ path: String) {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                print("can't delete file, path : \(path)")
                print(error.localizedDescription)
            }
        }
    }
    
    static func moveFile(at src: URL, to dst: URL) {
        do {
            try FileManager.default.moveItem(at: src, to: dst)
        } catch {
            print("can't move file, src url : \(src), dst url : \(dst)")
            print(error.localizedDescription)
        }
    }
    
    static func renameFileIfExist(old: URL, new: URL) {
        if FileManager.default.fileExists(atPath: old.path) {
            do {
                try FileManager.default.moveItem(at: old, to: new)
            } catch {
                print("can't rename file, old url : \(old), new url : \(new)")
                print(error.localizedDescription)
            }
        }
    }
    
    static func copyFile(src: URL, dst: URL) {
        
        if FileManager.default.fileExists(atPath: src.path) {
            do {
                try FileManager.default.copyItem(at: src, to: dst)
            } catch {
                print("can't copy file, src url : \(src), dst url : \(dst)")
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func fileExist(_ path: URL) -> Bool {
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    static func openFolder(_ path: String) {
        var isDir : ObjCBool = true
        if !FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            print("open folder failed, directory is not exist, path is \(path)")
            return
        }
        NSWorkspace.shared.selectFile(path, inFileViewerRootedAtPath: path)
    }
    
}
