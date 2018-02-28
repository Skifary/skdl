//
//  FFmpeg.swift
//  skdl
//
//  Created by Skifary on 27/02/2018.
//  Copyright © 2018 skifary. All rights reserved.
//

import Foundation

func ffmpegPATH() -> String? {
    
    guard let path = Shell.excuteCommand("which ffmpeg") else {
        return nil
    }
    
    if path.isEmpty {
        return nil
    }
    return path.substring(to: path.count - 8)
}

func hasFFmpeg() -> Bool {
    
    if ffmpegPATH() == nil {
        return false
    }

    return true
}
