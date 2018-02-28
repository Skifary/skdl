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
//        // check exist
//        if !FileManager.default.fileExists(atPath: path) {
//            do {
//              //  try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
//                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
//            } catch {
//                print("can't create folder,url : \(url)")
//                print(error.localizedDescription)
//            }
//        }
    }
    
    public static func createDirectoryIfNotExist(_ path: String) {
        // check exist
        if !FileManager.default.fileExists(atPath: path) {
            do {
                //  try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
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
    
    static func deleteFileIfExist(url: URL) {
        
        deleteFileIfExist(url.path)
        //let path = url.path
//        if FileManager.default.fileExists(atPath: path) {
//            do {
//                try FileManager.default.removeItem(atPath: path)
//            } catch {
//                print("can't delete file, url : \(url)")
//                print(error.localizedDescription)
//            }
//        }
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
