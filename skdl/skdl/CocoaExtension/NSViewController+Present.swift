//
//  NSViewController+Present.swift
//  skdl
//
//  Created by Skifary on 30/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa


extension NSViewController {
    
    func presentViewControllerFromTop(_ viewController: NSViewController) {
        presentViewController(viewController, animator: PresentAnimator.init(with: .top))
    }
    
    func presentViewControllerFromBottom(_ viewController: NSViewController) {
        presentViewController(viewController, animator: PresentAnimator.init(with: .bottom))
    }
    
    func presentViewControllerFromLeft(_ viewController: NSViewController) {
        presentViewController(viewController, animator: PresentAnimator.init(with: .left))
    }
    
    func presentViewControllerFromRight(_ viewController: NSViewController) {
        presentViewController(viewController, animator: PresentAnimator.init(with: .right))
    }
    
}
