//
//  Queue.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/27/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import UIKit
/**
 FIFO Queue
 */
class Queue: NSObject {

    private var array: Array<Any> = []
    private let queue: DispatchQueue
    
    override init() {
        self.queue = DispatchQueue(label: "com.Instabug.Queue")
    }
    
    /**
     @brief Enqueues an object to the end of the queue
     */
    func enqueue(_ object: Any) {
        queue.sync {
            array.append(object)
        }
    }
    
    /**
     @brief Dequeues an object from the beginning of the array
     */
    func dequeue() -> Any {
        return array.remove(at: 0)
    }
    
    func count() -> Int {
        return array.count
    }
}
