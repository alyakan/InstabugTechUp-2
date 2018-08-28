//
//  BackendMock.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/27/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import UIKit

class BackendMock: NSObject {

    static let shared = BackendMock()
    private override init() {}
    
    private var receivers: Array<Receiver> = []
    
    func launch() {
        for receiver in receivers {
            receiver.start()
        }
    }
    
    func tearDown() {
        for receiver in receivers {
            receiver.stop()
        }
        
        receivers.removeAll()
    }
    
    func add(receiver: Receiver) {
        receivers.append(receiver)
    }
    
    func objects(ofKind kind: AnyClass) -> Array<Any>? {
        for receiver in receivers {
            if receiver.objectsClass() == kind {
                return receiver.objects
            }
        }
        
        return nil
    }
}
