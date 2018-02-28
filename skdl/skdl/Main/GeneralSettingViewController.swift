//
//  GeneralSettingViewController.swift
//  skdl
//
//  Created by Skifary on 28/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class GeneralSettingViewController: BasicViewController {

    //MARK:-
    
    var generalSettingView: GeneralSettingView {
        return view as! GeneralSettingView
    }
    
    override func loadView() {
        view = GeneralSettingView(frame: NSZeroRect)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generalSettingView.okTitle = "Save"
        generalSettingView.folderInput.isEditable = false
        
        generalSettingView.isUseLocalYTDL = PV.useLocalYTDL
        
        generalSettingView.isAutomaticUpdateYTDL = PV.automaticUpdateYTDL
        
        let nsPath: NSString = NSString(string: PV.localStoragePath)
        generalSettingView.folderInput.stringValue = nsPath.lastPathComponent //PV.localStoragePath!
        
        NSButton.batchAddActions([
            generalSettingView.chooseFolderButton : #selector(chooseAction),
            generalSettingView.googleExtensionButton : #selector(jump2GoogleExtensionAction),
            generalSettingView.updateYTDLButton : #selector(updateYTDLAction),
            generalSettingView.openLogFolderButton : #selector(openLogFolderAction),
            generalSettingView.clearLogsButton : #selector(clearLogsAction),
            ], self)
        
        setVersion(ytdlController.shared.isUpdating)
        
        ytdlController.shared.register4UpdateStatus("GeneralSettingViewObserver") { (isUpdating) in
            self.setVersion(isUpdating)
        }
        
    }

    @objc fileprivate func chooseAction(_ sender: NSButton) {
        
        guard let url = FolderBrowser.chooseFolder(title: "Choose Folder") else {
            
            return
        }
        
        PV.localStoragePath = url.path
        generalSettingView.folderInput.stringValue = url.lastPathComponent
    }
    
    @objc fileprivate func jump2GoogleExtensionAction(_ sender: NSButton) {
        NSWorkspace.shared.open(URL(string: Config.shared.googleExtensionURL)!)
    }
    
    @objc fileprivate func updateYTDLAction(_ sender: NSButton) {
        ytdlController.shared.update()
    }
    
    @objc fileprivate func openLogFolderAction(_ sender: NSButton) {
        PathUtility.openFolder(LogManager.shared.logDir.path)
    }
    
    @objc fileprivate func clearLogsAction(_ sender: NSButton) {
        let enumerator: FileManager.DirectoryEnumerator? = FileManager.default.enumerator(atPath: LogManager.shared.logDir.path)

        while let file = enumerator?.nextObject() as? String {
            PathUtility.deleteFileIfExist(LogManager.shared.logDir.path + "/" + file)
        }
    }
    
    override func dismissAction(_ sender: NSButton) {
        ytdlController.shared.removeUpdateStatus("GeneralSettingViewObserver")
        super.dismissAction(sender)
    }
    
    override func okAction(_ sender: NSButton) {
        
        PV.useLocalYTDL =  generalSettingView.isUseLocalYTDL
        
        PV.automaticUpdateYTDL = generalSettingView.isAutomaticUpdateYTDL
        ytdlController.shared.removeUpdateStatus("GeneralSettingViewObserver")
        super.okAction(sender)
    }
    
    func setVersion(_ isUpdating: Bool) {
        if isUpdating {
            DispatchQueue.main.async {
                self.generalSettingView.setVersion("Updating")
            }
        } else {
            DispatchQueue.global().async {
                let verison = ytdlController.shared.version()
                DispatchQueue.main.async {
                    self.generalSettingView.setVersion(verison)
                }
            }
        }
    }
}
