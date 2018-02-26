//
//  AppDelegate+StatusBar.swift
//  skdl
//
//  Created by Skifary on 19/10/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Cocoa

internal extension AppDelegate {
    
    internal func statusItem() -> NSStatusItem {
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let image = NSImage(named: ImageName.StatusBarIcon)
        image?.size = NSMakeSize(17, 17)
        item.image = image
        item.action = #selector(action)
        return item
    }
    
    @objc fileprivate func action() {
        
        if popover == nil {
            let popover = NSPopover()
            popover.animates = true
            popover.contentSize = AppSize.Content
            let popoperViewController = PopoverViewController()
            popover.contentViewController = popoperViewController
            self.popover = popover
        }
        
        guard !popover.isShown else {
            closePopover()
            return
        }
        
        if monitor == nil {
            monitor = NSEvent.addGlobalMonitorForEvents(matching: .leftMouseUp, handler: { [weak self] (event) in
                self?.closePopover()
            })
        }
        
        guard let positionView = statusBarItem.button else {
            return
        }

        popover.show(relativeTo: positionView.frame, of: positionView, preferredEdge: NSRectEdge.maxY)
        
        //这里如果只设置一次，在添加有layer的图层的时候，会影响他 所以这里先修改成每次都设置
        // 避免重复设置背景颜色
//        guard !(popover.contentViewController?.view.superview?.wantsLayer)! else {
//            return
//        }
        setPopover(background: Color.Main)
    }
    
    fileprivate func closePopover() {
        guard popover.isShown else {
            return
        }
        popover.close()
        
        //???? 这里是要写什么来着？

        popoverCloseEvent.forEach({ (event) in
            event()
        })
        
        guard let monitor = self.monitor else {
            return
        }
        NSEvent.removeMonitor(monitor)
        self.monitor = nil
    }
    
    fileprivate func setPopover(background color: NSColor) {
        
        guard let popoverViewController = popover.contentViewController else {
            return
        }
        
        // 设置三角区域的颜色
        let popoverView = popoverViewController.view
        popoverView.superview?.wantsLayer = true
        popoverView.superview?.layer?.backgroundColor = color.cgColor
        
    }
    
}
