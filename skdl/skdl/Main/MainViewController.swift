//
//  MainViewController.swift
//  skdl
//
//  Created by Skifary on 14/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class MainViewController: NSViewController {

    fileprivate var downloadViewController = OnlineVideoDownloaderViewController()
    
    fileprivate var localViewController = OfflineVideoManagerViewController()
    
    
    //MARK:- api
    
    internal func showDownloadView() {
        localViewController.view.isHidden = true
        downloadViewController.view.isHidden = false
    }
    
    internal func showManagerView() {
        localViewController.view.isHidden = false
        downloadViewController.view.isHidden = true
    }
    
    //MARK:- life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
        addSubViewControllers()
        showDownloadView()
    }
    
    
    //MARK:-
    
    fileprivate func addSubViewControllers() {
        addChildViewController(downloadViewController)
        addChildViewController(localViewController)
        self.view.addSubview(downloadViewController.view)
        downloadViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.view.addSubview(localViewController.view)
        localViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    

    
}
