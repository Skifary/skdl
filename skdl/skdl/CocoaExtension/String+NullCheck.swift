//
//  String+NullCheck.swift
//  skdl
//
//  Created by Skifary on 2018/4/2.
//  Copyright © 2018 skifary. All rights reserved.
//

import Foundation

extension String {
    
    static func isNullOrEmpty(_ str: String?) -> Bool {
        guard let str = str else {
            return true
        }
        return str.isEmpty
    }
    
}
