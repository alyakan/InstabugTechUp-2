//
//  ConfigurationManager.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/26/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import UIKit

class ConfigurationManager: NSObject {

    static let shared = ConfigurationManager()
    
    private let configurations: Dictionary<String, Configuration>
    
    // Prevents others from using default initializer
    private override init() {
        let logConfiguration = Configuration {
            print("Configuration for key `\(logConfigurationKey)` executed!")
        }
        
        self.configurations = [
            logConfigurationKey: logConfiguration
        ]
    }
    
    func applyConfigurations(matchingArguments arguments: Array<String>) {
        print("Applying configurations ...")
        for arg in arguments {
            guard let config = self.configurations[arg] else {
                let idx = arg.index(arg.startIndex, offsetBy: 20)
                print("Couldn't find configuration for argument: \(arg[...idx])!")
                continue
            }
            
            config.execute()
        }
    }
    
}
