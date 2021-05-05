//
//  SearchRecipesCase.swift
//  RecipleaseTests
//
//  Created by Yakoub on 08/10/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import XCTest
import Foundation
@testable import Reciplease
@testable import Alamofire

class SearchRecipesCase: XCTestCase {

    private var recipeService =  MokeRecipeService()
    override func setUp() {
            super.setUp()
        }


    func testRecipeSearch() {
        
        recipeService.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Performs a request")
        recipeService.mySearchRecipes(ingredients: "chicken, potato") { (recipes, response) in
            XCTAssertNotNil(recipes)
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testRecipeSearchNotOk() {
        recipeService.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Performs a request")
        recipeService.mySearchRecipes(ingredients: "c") { (recipes, response) in
            XCTAssertNil(recipes)
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testImageRequestOk() {
        recipeService.shouldReturnError = false

        let expectation = XCTestExpectation(description: "Performs a request")

        recipeService.imageFrom(url: URL(string: "https:")!) { (data, error) in
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testImageRequestNotOk() {
        recipeService.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Performs a request")

        recipeService.imageFrom(url: URL(string: "https://d")!) { (data, error) in
            XCTAssertNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
