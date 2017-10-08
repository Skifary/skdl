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
    var localManagerViewController = LocalManagerViewController()
    
    
    //MARK:- api
    
    func showFileDownloadView() {
        localManagerViewController.view.isHidden = true
        downloadViewController.view.isHidden = false
    }
    
    func showFileManagerView() {
        localManagerViewController.view.isHidden = false
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
        addChildViewController(localManagerViewController)
        self.view.addSubview(downloadViewController.view)
        downloadViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.view.addSubview(localManagerViewController.view)
        localManagerViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    

    
}
