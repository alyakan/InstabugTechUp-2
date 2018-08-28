//
//  Configuration.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/26/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import UIKit

class Configuration: NSObject {
    
    private var block: () -> ()
    
    init(withBlock block: @escaping () -> ()) {
        self.block = block
    }

    func execute() {
        print("Executing configuration ...")
        self.block()
    }
}
