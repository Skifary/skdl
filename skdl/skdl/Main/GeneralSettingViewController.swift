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
        
        generalSettingView.okTitle = "SAVE"
        generalSettingView.folderInput.isEditable = false
        generalSettingView.folderInput.stringValue = PV.localStoragePath!
        
        NSButton.batchAddActions([
            generalSettingView.chooseFolderButton : #selector(chooseAction),
            generalSettingView.googleExtensionButton : #selector(jump2GoogleExtensionAction),
            ], self)
    }
    
    @objc fileprivate func chooseAction(_ sender: NSButton) {
        
        guard let url = FolderBrowser.chooseFolder(title: "Choose Folder") else {
            
            return
        }
        
        PV.localStoragePath = url.path
        generalSettingView.folderInput.stringValue = url.path
    }
    
    @objc fileprivate func jump2GoogleExtensionAction(_ sender: NSButton) {
        //....
    }
    
}
