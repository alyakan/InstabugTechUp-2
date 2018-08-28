//
//  Print.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/26/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import Foundation

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    let output = items.map { "[UITestConfigurations] \($0)" }.joined(separator: separator)
    Swift.print(output, terminator: terminator)
}
