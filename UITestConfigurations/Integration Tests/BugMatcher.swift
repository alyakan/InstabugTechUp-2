//
//  BugMatcher.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/26/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import UIKit

class BugMatcher: NSObject {
    
    private var requests: Set <URLRequest> = Set()

    func isValid(request: URLRequest) -> Bool {
        return request.url == URL(string: "\(baseURL)\(bugsURL)")
    }
    
    func isDuplicate(request: URLRequest) -> Bool {
        if requests.contains(request) {
            return true
        }
        
        requests.insert(request)
        return false
    }
    
    func bug(fromData data: Data?) -> Bug? {
        guard let data = data else {
            print("Couldn't find data in the response")
            return nil
        }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let dict = jsonObject as? Dictionary<String, Any> else {
                print("Couldn't convert json to dictionary")
                return nil
            }
            
            print("Data: \(dict)")
            return Bug(withDictionary: dict)
        } catch {
            print("Couldn't deserialize data")
            return nil
        }
    }
}
