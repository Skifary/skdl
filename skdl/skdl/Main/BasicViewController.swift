//
//  BasicViewController.swift
//  skdl
//
//  Created by Skifary on 19/01/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Cocoa

class BasicViewController: NSViewController {

    //MARK:-
    
    var basicView: BasicView {
        return view as! BasicView
    }
    
    //MARK:- life cycle
    
    override func loadView() {
        view = BasicView(frame: NSRect.zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setActions()
    }
    
    fileprivate func setActions() {
        
//        let actionDictionary: [NSButton : Selector?] = [
//            basicView.backButton : #selector(dismissAction),
//            basicView.okButton : #selector(okAction),
//        ]
//
//        actionDictionary.forEach { (button, aciton) in
//            button.target = self
//            button.action = aciton
//        }
        
        NSButton.batchAddActions([
            basicView.backButton : #selector(dismissAction),
            basicView.okButton : #selector(okAction),
            ], self)
        
    }
    
    //MARK:- action
    
    @objc func dismissAction(_ sender: NSButton) {
        dismissViewController(self)
    }
    
    @objc func okAction(_ sender: NSButton) {
        dismissViewController(self)
    }
    
}


