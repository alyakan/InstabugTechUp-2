//
//  Controller.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/26/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import UIKit

let baseURL = "https://demo9584690.mockable.io/"
let bugsURL = "bugs"
let dateParameter = "date"
let emailParameter = "email"
let snapshotParameter = "snapshot"

class Controller: NSObject {
    
    private let snapshot: Snapshot

    init(withSnapshot snapshot: Snapshot) {
        self.snapshot = snapshot
    }
    
    func submit(withEmail email: String?) {
        // Create a bug from the snapshot and email
        let bug = Bug(withSnapshot: snapshot, email: email)
        
        guard let url = URL(string: "\(baseURL)\(bugsURL)") else {
            print("Couldn't create url")
            return
        }
        
        var data: Data
        
        // Try to serialize the bug into Data
        do {
            data = try JSONSerialization.data(withJSONObject: bug.toDictionary(), options: .prettyPrinted)
        } catch {
            print("Couldn't serialize data")
            return
        }
        
        // Create a request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        
        // Execute the request
        execute(request: request)
    }
    
    private func execute(request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("Response: \(String(describing: response))")
            
            // Check that data is not nil
            guard let data = data else {
                print("Couldn't find data in the response")
                return
            }
            
            // Try to deserialize the Data into a dictionary
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let dict = jsonObject as? Dictionary<String, Any> else {
                    print("Couldn't convert json to dictionary")
                    return
                }
                print("Data: \(dict)")
            } catch {
                print("Couldn't deserialize data")
            }
        }
        
        task.resume()
    }
}
