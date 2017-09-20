//
//  MainViewController.swift
//  skdl
//
//  Created by Skifary on 14/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    var downloadViewController = MainDownloaderViewController()
    var fileManagerViewController = FileManagerViewController()
    
    
    //MARK:- api
    
    func showFileDownloadView() {
        fileManagerViewController.view.isHidden = true
        downloadViewController.view.isHidden = false
    }
    
    func showFileManagerView() {
        fileManagerViewController.view.isHidden = false
        downloadViewController.view.isHidden = true
    }
    
    //MARK:- life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
        addSubViewControllers()
        showFileDownloadView()
    }
    
    
    //MARK:-
    
    fileprivate func addSubViewControllers() {
        addChildViewController(downloadViewController)
        addChildViewController(fileManagerViewController)
        self.view.addSubview(downloadViewController.view)
        downloadViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.view.addSubview(fileManagerViewController.view)
        fileManagerViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    

    
}
