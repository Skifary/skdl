//
//  JSONHelper.swift
//  skdl
//
//  Created by Skifary on 08/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation

public class JSONHelper {
    
    public static func getDictionary(from json: String) -> [String : Any]? {
        guard let data = json.data(using: .utf8) else {
            print("can't get data from json, json : \(json)")
            return nil
        }
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dictionary = object as? [String : Any] ?? nil
            return dictionary
        } catch {
            print("JSONSerialization failed, json : \(json)")
        }
        return nil
    }
    
}
