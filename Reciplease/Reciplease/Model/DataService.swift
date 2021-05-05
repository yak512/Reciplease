//
//  Data.swift
//  Reciplease
//
//  Created by Yakoub on 16/02/2021.
//  Copyright © 2021 Yakoub. All rights reserved.
//

import Foundation
import CoreData

class DataService {

    var favoritRecipes: [FavoritRecipe] = []
    var persistenceService = PersistenceService()
    

    public func loadFavoriteRecipes() -> [FavoritRecipe] {
        var loadedRecipes = [FavoritRecipe]()
        let fetchRequest: NSFetchRequest<FavoritRecipe> = FavoritRecipe.fetchRequest()
        do {
            let allFavoriteRecipes = try persistenceService.context.fetch(fetchRequest)
            loadedRecipes = allFavoriteRecipes
        } catch {
             print("Error while loading Data")
        }
        return loadedRecipes
    }

    public func saveRecipe(myRecipe: Recipe!) {
        let saveFavRecipe = FavoritRecipe(context: persistenceService.context)
        saveFavRecipe.correctTime = myRecipe.correctTime
        saveFavRecipe.labelRecipe = myRecipe.label
        saveFavRecipe.ingredientsLines = myRecipe.ingredientLines as [NSString]
        let data = (myRecipe?.myImage)!.pngData()
        saveFavRecipe.imageRecipe = data
        saveFavRecipe.urlRecipe = myRecipe.url
        saveFavRecipe.isFav = true
        persistenceService.saveContext()
        favoritRecipes.append(saveFavRecipe)
    }

    public func deleteRecipe(favoriteRecipes: FavoritRecipe!) {
        guard let context = favoriteRecipes.managedObjectContext else {
            return
        }
        context.delete(favoriteRecipes)
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
}
