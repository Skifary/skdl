//
//  DLFileManager.swift
//  skdl
//
//  Created by Skifary on 03/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


class DLFileManager {
    
    //MARK:- property
    
    private lazy var files: [DLFile] = (NSKeyedUnarchiver.unarchiveObject(withFile: historyUrl.path) as? [DLFile]) ?? []
    
    var unfinishedFiles: [DLFile] {
        get {
            return files.filter { (file) -> Bool in
                return file.state == DLFile.State.uncompleted || file.state == DLFile.State.downloading
            }
        }
    }
    
    var finishedFiles: [DLFile] {
        get {
            return files.filter { (file) -> Bool in
                return file.state == DLFile.State.completed
            }
        }
    }
    
    let historyUrl = PathUtility.appSupportDirURL.appendingPathComponent(AppData.historyFile, isDirectory: false)
    
    //MARK:- singleton
    
    static let manager = DLFileManager()
    
    fileprivate init() {
    }
    
    
    //MARK:- api
    
    func save() {
        PathUtility.deleteFileIfExist(url: historyUrl)
        if !NSKeyedArchiver.archiveRootObject(files, toFile: historyUrl.path) {
            MessageAlert.log("Cannot save files history!")
        }
    }
    
    func add(_ file: DLFile) {
        if !files.contains(file) {
            files.append(file)
        }
    }
    
    func remove(_ file: DLFile) {
        files = files.filter { $0 != file }
    }
    
    func quitAndSave() {
        self.unfinishedFiles.forEach { (file) in
            file.task?.interrupt()
            file.state = DLFile.State.uncompleted
        }
        save()
    }
    
}
