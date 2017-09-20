//
//  SKQueue.swift
//  skdl
//
//  Created by Skifary on 12/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation


struct SKQueue<T> {
    
    fileprivate var _data: [T] = []
    
    
    var array: [T] {
        get {
            return _data
        }
    }
    
    var isEmpty: Bool {
        get {
            return _data.isEmpty
        }
    }
    
    var count: Int {
        get {
            return _data.count
        }
    }
    
    var front: T? {
        get {
            return _data.first
        }
    }
    
    var back: T? {
        get {
            return _data.last
        }
    }
    
    mutating func push(element: T) {
        _data.append(element)
    }

    mutating func pop() -> T {
        return _data.removeFirst()
    }
    
}
