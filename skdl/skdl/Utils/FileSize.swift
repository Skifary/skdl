//
//  FileSize.swift
//  skdl
//
//  Created by Skifary on 10/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

public class FileSize {
    
    public enum Unit: Int {
        case unkown = -1
        case b = 0
        case kb = 1
        case mb = 2
        case gb = 3
        var string: String {
            get {
                switch self {
                case .b: return "B"
                case .kb: return "K"
                case .mb: return "M"
                case .gb: return "G"
                case .unkown: return "unkown"
                }
            }
        }
    }

    static func format(size: Int64) -> String {
        var formatSize: Double = Double(size)
        var digits = -1
        while formatSize > 1 {
            formatSize /= 1000
            digits += 1
        }
        let unit = Unit(rawValue: digits)
        if unit == .unkown {
            return "unkown size"
        }
        formatSize *= 1000
        return String(format: "%.2f%@", formatSize, unit!.string)
    }
    
}
