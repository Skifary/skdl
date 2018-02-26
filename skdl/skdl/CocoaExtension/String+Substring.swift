//
//  String+Substring.swift
//  skdl
//
//  Created by Skifary on 02/02/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Foundation

extension String {
    
    func substring(from start: Int, to end: Int) -> String {
        let si = index(startIndex, offsetBy: start)
        let ei = index(startIndex, offsetBy: end)
        return String(self[si...ei])
    }
    
    func substring(from index: Int) -> String {
        return substring(from: index, to: count)
    }
    
    func substring(to index: Int) -> String {
        return substring(from: 0, to: index)
    }
    
}
