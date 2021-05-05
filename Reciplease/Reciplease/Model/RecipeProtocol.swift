//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Yakoub on 09/04/2021.
//  Copyright © 2021 Yakoub. All rights reserved.
//

import Foundation

protocol RecipeServiceProtocol {
    func mySearchRecipes(ingredients: String, completionHandler: @escaping ([Recipe]?, Bool) -> Void)
    func imageFrom(url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}
