//
//  JSONHelper.swift
//  skdl
//
//  Created by Skifary on 08/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

public class JSONHelper {
    
    public static func getDictionary(from json: String) -> [String : Any] {
        guard let data = json.data(using: .utf8) else {
                Log.logWithCallStack("json.data() failed, json: \(json)")
                return [:]
        }
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dictionary = object as? [String : Any] ?? [:]
            return dictionary
        } catch {
            Log.logWithCallStack("JSONSerialization failed, json: \(json)")
        }
        return [:]
    }
    
}
