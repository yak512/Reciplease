//
//  SearchRecipesCase.swift
//  RecipleaseTests
//
//  Created by Yakoub on 08/10/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import XCTest
@testable import Reciplease

class SearchRecipesCase: XCTestCase {

    let ingredient = "chicken,tomato"
    let service = RecipesService()
    
   func testGettingJSON() {
      let ex = expectation(description: "Expecting a JSON data not nil")

    service.myRecipes(ingredients: ingredient) { (recipes, response ) in
        XCTAssertTrue(response && recipes != nil)
        ex.fulfill()
    }
      waitForExpectations(timeout: 10) { (error) in
        if let error = error {
          XCTFail("error: \(error)")
        }
      }
    }
    
    func testGetImage() {
        
        let url  = URLComponents(string: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg")
        let ex = expectation(description: "Expecting a JSON data not nil")

        service.imageFrom(url: url!.url!) { (image, error) in
            XCTAssertNotNil(image)
            ex.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
          if let error = error {
            XCTFail("error: \(error)")
          }
        }
    }
    
   func testGetImageError() {
        
        let url  = URLComponents(string: "")
        let ex = expectation(description: "no image")

        service.imageFrom(url: url!.url!) { (image, error) in
            XCTAssertNil(image)
            ex.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
          if let error = error {
            XCTFail("error: \(error)")
          }
        }
    }

}
