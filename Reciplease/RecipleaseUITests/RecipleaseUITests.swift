//
//  RecipleaseUITests.swift
//  RecipleaseUITests
//
//  Created by Yakoub on 09/10/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import XCTest

class RecipleaseUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        //var continueAfterFailure = false
        
        app = XCUIApplication()
        
        app.launchArguments.append("ui-testing")
        sleep(1)
       // app.buttons["SearchButton"].tap()

    }
    
        func testSearchButton() {
            app = XCUIApplication()
            app.launch()
            app.buttons["Search"].tap()
        }
    
    func testSearchAdd() {
        app = XCUIApplication()
        app.launch()
        app.buttons["addButton"].tap()
    }
}
