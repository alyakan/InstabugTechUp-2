//
//  UITestConfigurationsUITests.swift
//  UITestConfigurationsUITests
//
//  Created by Aly Yakan on 8/26/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import XCTest

class UITestConfigurationsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        
        app.launchArguments.append(logConfigurationKey)
        app.launchEnvironment["UITESTS"] = "Yes"
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        print("Launching application ...")
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
