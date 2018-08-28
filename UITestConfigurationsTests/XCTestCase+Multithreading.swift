//
//  XCTestCase+Multithreading.swift
//  UITestConfigurationsTests
//
//  Created by Aly Yakan on 8/27/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func testMultithreading(withTimeout timeout: TimeInterval, changesBlock: @escaping (_ counter: Int) -> ()) {
        // Expectation to ensure last operation is fulfilled
        let expectation = XCTestExpectation(description: "Executing 1k operations was not successful")
        
        let opQ = OperationQueue()
        
        // Suspend operation queue
        opQ.isSuspended = true
        
        // Completion count for asserting that all blocks executed
        var completionCount = 0
        
        // Last operation which will depend on all other operations. To fulfill expectation
        let lastOp = BlockOperation {
            DispatchQueue.main.async {
                XCTAssertEqual(completionCount, 1000)
            }
            expectation.fulfill()
        }
        
        // Create 1000 operation blocks which execute the changes block in parallel
        for i in 0 ..< 1000 {
            let operation = BlockOperation {
                changesBlock(i)
                DispatchQueue.main.async {
                    completionCount += 1
                }
            }
            
            // Add the operation as a dependency for the last operation
            lastOp.addDependency(operation)
            
            // Add the operation to the queue
            opQ.addOperation(operation)
        }
        
        // Add the last operation to the queue
        opQ.addOperation(lastOp)
        
        // Unsuspend the queue
        opQ.isSuspended = false
        
        // Wait for the expectation to fulfill
        wait(for: [expectation], timeout: timeout)
    }
    
}
