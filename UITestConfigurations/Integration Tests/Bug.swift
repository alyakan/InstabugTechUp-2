//
//  Bug.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/27/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import Foundation

class Bug: NSObject {
    let snapshot: Snapshot
    var email: String?
    
    init(withSnapshot snapshot: Snapshot, email: String? = "") {
        self.snapshot = snapshot
        self.email = email
    }
    
    init(withDictionary dictionary: Dictionary<String, Any>) {
        guard let email = dictionary[emailParameter] as? String,
            let snapshot = dictionary[snapshotParameter] as? Dictionary<String, Any> else {
                print("Couldn't initialize bug from dictionary: \(dictionary)")
                fatalError()
        }
        self.email = email
        self.snapshot = Snapshot(withDictionary: snapshot)
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        return [
            emailParameter: email ?? "",
            snapshotParameter: snapshot.toDictionary()
        ]
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Bug else {
            return false
        }
        
        return (other.email == self.email && other.snapshot == self.snapshot)
    }
    
    override var description: String {
        return "{\n\temail: \(email ?? "No Email")\n\tsnapshot: \(snapshot.description)\n}"
    }
}
