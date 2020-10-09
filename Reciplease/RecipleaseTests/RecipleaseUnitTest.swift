//
//  RecippleaseUnitTest.swift
//  RecipleaseTests
//
//  Created by Yakoub on 09/10/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import XCTest
import Foundation

class RecipleaseUnitTest: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        //var continueAfterFailure = false
        
        app = XCUIApplication()
        
        app.launchArguments.append("ui-testing")
        sleep(1)
        app.buttons["SearchButton"].tap()

        
    }

  /*  func testGoingThroughtOnbording() {
        //app.launch()
        let textField = app.textFields["IngredientsTextField"]
        textField.tap()
        textField.clearText(andReplaceWith: "Chicken")

        
        XCTAssertEqual(textField.value as! String, "Chicken", "Text field value is not correct")

    }*/

}

extension XCUIElement {
    func clearText(andReplaceWith newText:String? = nil) {
        tap()
        press(forDuration: 1.0)
        var select = XCUIApplication().menuItems["Select All"]

        if !select.exists {
            select = XCUIApplication().menuItems["Select"]
        }
        //For empty fields there will be no "Select All", so we need to check
        if select.waitForExistence(timeout: 0.5), select.exists {
            select.tap()
            typeText(String(XCUIKeyboardKey.delete.rawValue))
        } else {
            tap()
        }
        if let newVal = newText {
            typeText(newVal)
        }
    }
}
