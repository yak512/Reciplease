//
//  CoreDataCase.swift
//  RecipleaseTests
//
//  Created by Yakoub on 17/02/2021.
//  Copyright © 2021 Yakoub. All rights reserved.
//

import XCTest
import Foundation
@testable import Reciplease

class CoreDataCase: XCTestCase {

    var dataService: DataService!
    var url: URL!
    var favoritRecipes: [FavoritRecipe]!
    var myRecipe: Recipe!

    override func setUp() {
        super.setUp()
        dataService = DataService()
        dataService.persistenceService = PersistenceServiceTest()
        favoritRecipes = [FavoritRecipe]()
        url = URL(string: "www.google.fr")
        myRecipe = Recipe(label: "Poulet", totalTime: 235.0, ingredientLines: ["bob", "bob"], imageUrl: url, url: url, correctTime: "bobl")
    }

    func createRecipe() {
        dataService.saveRecipe(myRecipe: myRecipe)
        XCTAssertNotNil(dataService.favoritRecipes[0])
    }

    func testSaveFavoriteRecipe() {
        createRecipe()
    }

    func testCanLoadRecipe() {
        favoritRecipes = dataService.loadFavoriteRecipes()
        XCTAssertEqual(favoritRecipes.count, 0)
    }

    func testLoadRecipes() {
        createRecipe()
        favoritRecipes = dataService.loadFavoriteRecipes()
        XCTAssertNotNil(favoritRecipes)
    }

    func testDeleteRecipe() {
        createRecipe()
        favoritRecipes = dataService.loadFavoriteRecipes()
        let numberRecipe = favoritRecipes[0].labelRecipe!
        print("number of recipes before delete \(String(describing: favoritRecipes[0].labelRecipe))")
        dataService.deleteRecipe(favoriteRecipes: favoritRecipes[0])
        print("number of recipes AFTER delete \(String(describing: favoritRecipes[0].labelRecipe))")
        XCTAssertNotEqual(numberRecipe, favoritRecipes[0].labelRecipe)
    }
}
