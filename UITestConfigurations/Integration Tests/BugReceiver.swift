//
//  BugReceiver.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/27/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import UIKit
import OHHTTPStubs

protocol Receiver {
    func start()
    func stop()
    func objectsClass() -> AnyClass
    
    var objects: Array<Any> {get}
}

let bugID = "Bug_ba802d5b9a680982c3a7f29b306f50dd"

class BugReceiver: Receiver {
    
    private var stubs: Array<OHHTTPStubsDescriptor> = []
    private(set) var objects: Array<Any> = []
    
    func start() {
        let matcher = BugMatcher()
        
        let stub = OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            
            // Check if the request is a bug request
            if matcher.isValid(request: request) {
                
                // This block is executed multiple times by OHHTTPStubs so we check if the request has been made before.
                if matcher.isDuplicate(request: request) == false {
                    // The parse here is to use OHHTTPStub's extension on NSURLRequest
                    let req = request as NSURLRequest
                    
                    // Create a bug from the request's body to store it
                    guard let bug = matcher.bug(fromData: req.ohhttpStubs_HTTPBody()) else {
                        print("Couldn't create bug from request data")
                        return false
                    }
                    
                    print("Successfully created bug from response\n\(bug)")
                    self.objects.append(bug)
                }
                
                return true
            }
            
            return false
        }) { (request) -> OHHTTPStubsResponse in
            // Response similar to the backend's response to our request. This will be received by the Controller
            // in the DataTask that is running.
            let data = try! JSONSerialization.data(withJSONObject: ["id": bugID], options: .prettyPrinted)
            return OHHTTPStubsResponse(data: data, statusCode: 200, headers: ["Content-Type": "applicaiton/json"])
        }
        
        stubs.append(stub)
    }

    func stop() {
        for stub in stubs {
            OHHTTPStubs.removeStub(stub)
        }
        
        self.stubs.removeAll()
    }
    
    func objectsClass() -> AnyClass {
        return Bug.self
    }
}
