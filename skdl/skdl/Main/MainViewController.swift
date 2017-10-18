//
//  MainViewController.swift
//  skdl
//
//  Created by Skifary on 14/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class MainViewController: NSViewController {

    fileprivate let downloadViewController = OnlineVideoDownloaderViewController()
    
    fileprivate let localViewController = OfflineVideoManagerViewController()
    
    let controlBar = ControlBarView()
    
    let displayView = MainDisplayView()
    
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
        
      //  addChildControllers()
        
        setSubView()
        
        showDownloadView()
    }
    
    
    //MARK:-
    
    fileprivate func setSubView() {
        view.addSubview(controlBar)
        view.addSubview(displayView)
        controlBar.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(70)
        }
        displayView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(controlBar.snp.right)
        }
        
        let displaySubviews = [downloadViewController.view, localViewController.view]
        
        displaySubviews.forEach { (view) in
            displayView.addSubview(view)
            view.snp.makeConstraints({ (make) in
                make.left.right.top.bottom.equalToSuperview()
            })
        }
        
    }
    
//    fileprivate func addSubViewControllers() {
//        //addChildViewController(downloadViewController)
//        //addChildViewController(localViewController)
//        self.view.addSubview(downloadViewController.view)
//        downloadViewController.view.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//        self.view.addSubview(localViewController.view)
//        localViewController.view.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalToSuperview()
//        }
//    }
//

    
}
