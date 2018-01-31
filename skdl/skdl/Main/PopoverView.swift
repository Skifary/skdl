//
//  PopoverView.swift
//  skdl
//
//  Created by Skifary on 20/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal class PopoverView: NSView {
    

    internal let settingButton: NSButton = NSButton.button(with: ImageName.Setting)

    internal let openFolderButton: NSButton = NSButton.button(with: ImageName.Folder)
    
    internal let newTaskButton: NSButton = NSButton.button(with: ImageName.NewTask)
    
    internal let tableContainerView: NSScrollView = {
        let scrollView = NSScrollView(frame: NSZeroRect)
        
        scrollView.drawsBackground = false
        scrollView.borderType = .noBorder
        
        return scrollView
    }()
    
    internal let tableView: ContentTableView = ContentTableView(frame: NSZeroRect)
    
  
    //MARK:-
    internal convenience init() {
        self.init(frame: NSZeroRect)
        setSubviews()
    }
    
    // 这个玩意会在view变形的时候绘制
    override func draw(_ dirtyRect: NSRect) {
        
        // 小tips NSGradient 需要一个context上下文 才能绘制！
        let gradient = NSGradient(colors: [Color.Main/*, Color.Minor*/])
        let rect = NSMakeRect(0, 0, NSWidth(frame), NSHeight(frame))
        gradient?.draw(in: rect, angle: -90.0)

    }
    
    fileprivate func setSubviews() {
    
        tableContainerView.contentView.documentView = tableView
        
        addSubviews([settingButton, openFolderButton, newTaskButton, tableContainerView])
        
        settingButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8)
            make.width.height.equalTo(18.0)
            make.bottom.equalTo(self.snp.top).offset(AppSize.Content.height - 8)
        }

        openFolderButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.settingButton.snp.left).offset(-8)
            make.width.height.equalTo(18.0)
            make.bottom.equalTo(settingButton.snp.bottom)
        }
        
        newTaskButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.width.height.equalTo(17.0)
            make.bottom.equalTo(settingButton.snp.bottom)
        }
        
        tableContainerView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.width.equalTo(AppSize.Content.width - 16)
            make.height.equalTo(AppSize.Content.height - 42)
        }
        
    }
    
    //MARK:- api
}
