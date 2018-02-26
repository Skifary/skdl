//
//  PresentAnimator.swift
//  skdl
//
//  Created by Skifary on 07/12/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation
import Cocoa


class PresentAnimator: NSObject, NSViewControllerPresentationAnimator {
    
    enum Direction {
        case left
        case right
        case top
        case bottom
    }
    
    public var fromFrame: NSRect!
    
    public var toFrame: NSRect!
    
    public var direction: Direction = .bottom
    
    init(with direction: Direction = .bottom, fromFrame: NSRect? = nil,toFrame: NSRect? = nil) {
        super.init()
        self.fromFrame = fromFrame
        self.toFrame = toFrame
        self.direction = direction
    }
    
    public func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        if fromFrame == nil {
            let frame = fromViewController.view.bounds
            var dx: CGFloat = 0
            var dy: CGFloat = 0
            switch direction {
            case .bottom:
                dx = 0
                dy = -frame.height
                break
            case .top:
                dx = 0
                dy = frame.height
                break
            case .right:
                dx = frame.width
                dy = 0
                break
            case .left:
                dx = -frame.width
                dy = 0
                break
            }
            fromFrame = frame.offsetBy(dx: dx, dy: dy)
        }
        
        if toFrame == nil {
            toFrame = fromViewController.view.bounds
        }
        
        fromViewController.addChildViewController(viewController)
    
        viewController.view.frame = fromFrame
        fromViewController.view.addSubview(viewController.view)
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.4
            viewController.view.animator().frame = toFrame
        }, completionHandler: nil)
        
        // 需要重新计算 view loop  
        fromViewController.view.window?.recalculateKeyViewLoop()
    }
    
    public func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.4
            viewController.view.animator().frame = fromFrame
        }) {
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
        }
    }
    
}
