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
    
        func testFavoriteButton() {
            app = XCUIApplication()
            app.launch()
            app.buttons["Favorites"].tap()
            XCTAssert(app.buttons["Favorites"].exists)
            
        }
    
        func testFavoriteButtonthenSearchButton() {
            app = XCUIApplication()
            app.launch()
            app.buttons["Favorites"].tap()
            XCTAssert(app.buttons["Favorites"].exists)
            sleep(1)
            app.buttons["Search"].tap()
            sleep(1)
            XCTAssert(app.buttons["Search"].exists)
            sleep(1)

    }
    
    
    func testSearchRecip() {
        app = XCUIApplication()
        app.launch()
        let ingredients = "Chicken"
        let textField = app.textFields["ingredientText"]
        textField.tap()
        for i in ingredients {
            textField.typeText(i.description)
            sleep(1/2)

        }
        XCTAssertEqual(textField.value as! String, "Chicken", "Equal")
        app.buttons["addButton"].tap()
        app.tap()
        app.buttons["searchButton"].tap()
        sleep(3)
        app.tap()
        sleep(2)
        app.buttons["Get directions"].tap()
        sleep(2)
        app.buttons["Done"].tap()
        sleep(1)
    }
    
    func testButtonExist() {
        app = XCUIApplication()
        app.launch()
        XCTAssert(app.textFields["ingredientText"].exists)
        XCTAssert(app.buttons["addButton"].exists)
        XCTAssert(app.buttons["clearButton"].exists)
        XCTAssert(app.buttons["searchButton"].exists)
    }
    
    func testClear() {
        app = XCUIApplication()
        app.launch()
        let textField = app.textFields["ingredientText"]
        textField.tap()
        textField.typeText("Chicken")
        sleep(1)
        app.buttons["addButton"].tap()
        sleep(1)
        app.buttons["clearButton"].tap()
        XCTAssertEqual(textField.value as! String, "Lemon, Cheese, Sausages...", "Equal")

    }
        
    func testSearchRecipAndBack() {
            app = XCUIApplication()
            app.launch()
            let ingredients = "Chicken"
            let textField = app.textFields["ingredientText"]
            textField.tap()
            for i in ingredients {
                textField.typeText(i.description)
                sleep(1/2)

            }
            XCTAssertEqual(textField.value as! String, "Chicken", "Equal")
            app.buttons["addButton"].tap()
            app.tap()
            app.buttons["searchButton"].tap()
            sleep(3)
            app.tap()
            sleep(2)
            app.buttons["Back"].tap()
            sleep(1)
        }
    
    func testSearchRecipFavorit() {
        app = XCUIApplication()
        app.launch()
        let ingredients = "Chicken"
        let textField = app.textFields["ingredientText"]
        textField.tap()
        for i in ingredients {
            textField.typeText(i.description)
        }
        app.buttons["addButton"].tap()
        app.tap()
        app.buttons["searchButton"].tap()
        sleep(3)
        app.tap()
        app.buttons["favorit"].tap()
        sleep(2)
        app.buttons["Favorites"].tap()
        sleep(2)
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        app.buttons["Get directions"].tap()
        sleep(2)
        app.buttons["Done"].tap()
        sleep(2)
    }
    
    func testSearchRecipRemoveFavorit() {
        app = XCUIApplication()
        app.launch()
       
        app.buttons["Favorites"].tap()
        sleep(2)
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        sleep(2)
        app.buttons["favorit"].tap()
        sleep(2)
        app.buttons["Back"].tap()
        sleep(2)
    }
    
}
