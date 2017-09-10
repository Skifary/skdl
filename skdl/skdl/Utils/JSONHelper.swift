//
//  JSONHelper.swift
//  skdl
//
//  Created by Skifary on 08/09/2017.
//  Copyright © 2017 skifary. All rights reserved.
//

import Foundation





class JSONHelper {
    
    
    class func convertJSONToDictionary(jsons: [String]) -> [Dictionary<String, Any>]? {

        var dics:[Dictionary<String, Any>] = []
        jsons.forEach { (json) in
            let data = json.data(using: .utf8)
            let dic = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            if dic != nil {
                dics.append(dic as! [String : Any])
            }
        }
        return dics
        
    }
    
    
    
}
