//
//  RecipesService.swift
//  Reciplease
//
//  Created by yakoub on 25/09/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import Foundation
import Alamofire

class RecipesService {
        
    func myRecipes(ingredients: String, completionHandler: @escaping ([Recipe]?, Bool) -> Void) {
        let parameters: Parameters = ["q": ingredients, "app_id": "30e6a123", "app_key": "670c84e334255a323628ebfd7aaf243f", "to": 25]
        AF.request("https://api.edamam.com/search", method: .get, parameters: parameters).responseJSON { (response) in
                DispatchQueue.main.async {
                    if let data = response.data {
                    guard  let responseJson =  try? JSONDecoder().decode(Response.self, from: data) else {
                        completionHandler(nil, false)
                        return
                    }
                        let allRecipes = self.getRecipes(responseJson: responseJson)
                        completionHandler(allRecipes, true)
                    } else {
                        completionHandler(nil, false)
                }
            }
        }
    }

    private func getRecipes(responseJson: Response) -> [Recipe] {
        var i = 0
        var allRecipes = [Recipe]()
        while (i < responseJson.hits.count) {
            let time = self.correctTime(time: responseJson.hits[i].recipe.totalTime)
            let recipes = Recipe(label: responseJson.hits[i].recipe.label, totalTime: responseJson.hits[i].recipe.totalTime, ingredientLines: responseJson.hits[i].recipe.ingredientLines, imageUrl: responseJson.hits[i].recipe.image, url: responseJson.hits[i].recipe.url, correctTime: time)
            allRecipes.append(recipes)
            i += 1
        }
        return allRecipes
    }
    
    func imageFrom(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        AF.request(url).responseData { response in
            guard let data = response.data else {
                completionHandler(nil, response.error)
                return
            }
            let image = UIImage(data: data)
            completionHandler(image, nil)
        }
    }
}

extension RecipesService {
    
    private func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    private func correctTime(time: Float) -> String {
        var correctTime = ""
        let timeInt = minutesToHoursMinutes(minutes: Int(time))
        if (timeInt.hours == 0 && timeInt.leftMinutes == 0) {
            correctTime = "???"
            return correctTime
        } else if (timeInt.hours == 0) {
            correctTime = "\(timeInt.leftMinutes) min"
            return correctTime

        } else if (timeInt.hours >= 1 && timeInt.leftMinutes == 0) {
            if timeInt.hours == 1 {
            correctTime = "\(timeInt.hours) hour"
            return correctTime
            } else {
                correctTime = "\(timeInt.hours) hours"
                return correctTime
            }
        } else {
            correctTime = "\(timeInt.hours)h\(timeInt.leftMinutes)min"
            return correctTime
        }

    }
}

struct Recipe {
    var label: String
    var totalTime: Float
    var ingredientLines: [String]
    var imageUrl: URL
    var url: URL
    var correctTime: String
    var myImage = UIImage()
}


struct Response: Codable {
    
    struct Recip: Codable {
        var recipe: RecipInfo
    }
    
    struct RecipInfo: Codable {
        var label: String
        var totalTime: Float
        var ingredientLines: [String]
        var image: URL
        var url: URL
    }
    
    var hits: [Recip]
}
