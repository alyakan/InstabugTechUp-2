//
//  Snapshot.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/27/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import Foundation

class Snapshot: NSObject {
    
    let date: Date
    
    override init() {
        self.date = Date()
    }
    
    init(withDictionary dictionary: Dictionary<String, Any>) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        guard let dateString = dictionary[dateParameter] as? String else {
            print("Couldn't initialize snapshot from dictionary: \(dictionary)")
            fatalError()
        }
        
        guard let interval = Double(dateString) else {
            print("Couldn't get interval from string \(dateString)")
            fatalError()
        }
        
        self.date = Date(timeIntervalSinceReferenceDate: interval)
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        return [dateParameter: "\(date.timeIntervalSinceReferenceDate)"]
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Snapshot else {
            return false
        }
        
        return other.date == self.date
    }
    
    override var description: String {
        return "{\n\tdate: \(date)\n}"
    }
}
