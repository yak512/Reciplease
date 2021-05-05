//
//  MockRecipeService.swift
//  RecipleaseTests
//
//  Created by Yakoub on 09/04/2021.
//  Copyright © 2021 Yakoub. All rights reserved.
//

import Foundation
import UIKit
@testable import Reciplease

class MokeRecipeService {
    
    var shouldReturnError = false
    var recipeWasCalled = false
    var imageWasCalled = false
    var url: URL!

    
    enum MockServiceError: Error {
        case recipe
        case image
    }
    
    func reset() {
        shouldReturnError = false
        recipeWasCalled = false
        imageWasCalled = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
   
    
    var recipesData = [Recipe(label: "Poulet", totalTime: 235.0, ingredientLines: ["bob", "bob"], imageUrl: URL(string: "www.google.fr")!, url: URL(string: "www.google.fr")!, correctTime: "bobl"), Recipe(label: "Poulet", totalTime: 235.0, ingredientLines: ["bob", "bob"], imageUrl: URL(string: "www.google.fr")!, url: URL(string: "www.google.fr")!, correctTime: "bobl")]

    var myImage: UIImage!
    var imageData = UIImage(named: "image")?.pngData()
    
}

extension MokeRecipeService: RecipeServiceProtocol {

    func mySearchRecipes(ingredients: String, completionHandler: @escaping ([Recipe]?, Bool) -> Void) {
        recipeWasCalled = true
        
        if shouldReturnError {
            completionHandler(nil, false)
        } else {
            completionHandler(recipesData, true)
        }  
    }
    
    func imageFrom(url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        imageWasCalled = true
        if shouldReturnError {
            completionHandler(nil, MockServiceError.image)
        } else {
            completionHandler(imageData, nil)
        }
    }
    
    
}
