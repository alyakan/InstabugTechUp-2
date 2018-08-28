//
//  UITestConfigurationsTests.swift
//  UITestConfigurationsTests
//
//  Created by Aly Yakan on 8/26/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import XCTest
@testable import UITestConfigurations

class UITestConfigurationsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let mock = BackendMock.shared
        
        // Cleanup before starting
        mock.tearDown()
        
        // Attach a receiver for bug requests which will setup OHHTTPStubs to intercept network calls
        mock.add(receiver: BugReceiver())
        
        // Launch the backend mock which just starts all attached receivers
        mock.launch()
    }
    
    override func tearDown() {
        BackendMock.shared.tearDown()
        super.tearDown()
    }
    
    func testSubmitBug() {
        let mock = BackendMock.shared
        
        // Create a snapshot and give it to the controller
        let snapshot = Snapshot()
        let controller = Controller(withSnapshot: snapshot)
        
        // When
        controller.submit(withEmail: "test@mail.com")
        
        // For async operations
        RunLoop.current.run(until: Date.init(timeIntervalSinceNow: 0.1))
        
        // Get objects of kind Bug from BackendMock.
        // The BackendMock here queries all of its receivers to get the objects of the given type.
        // Any receiver that receives a request, will try to create an object from the request's http body. It will then
        // store all the objects from all the requests.
        guard let bugs = mock.objects(ofKind: Bug.self) as? [Bug] else {
            XCTFail("There were no objects of kind Bug in BackendMock")
            return
        }
        
        // Expected bug from the snapshot
        let expectedBug = Bug(withSnapshot: snapshot, email: "test@mail.com")
        XCTAssertEqual(bugs.count, 1)
        XCTAssertEqual(bugs, [expectedBug])
    }
    
    func testMultithreadingEnqueuing() {
        let queue = Queue()
        testMultithreading(withTimeout: 5) { (counter) in
            let string = "\(counter)"
            
            queue.enqueue(string)
        }
        XCTAssertEqual(queue.count(), 1000)
    }
    
}
