//
//  FavoritRecipe+CoreDataProperties.swift
//  Reciplease
//
//  Created by yakoub on 05/10/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoritRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritRecipe> {
        return NSFetchRequest<FavoritRecipe>(entityName: "FavoritRecipe")
    }

    @NSManaged public var correctTime: String?
    @NSManaged public var imageRecipe: Data?
    @NSManaged public var ingredientsLines: [NSString]
    @NSManaged public var labelRecipe: String?
    @NSManaged public var urlRecipe: URL?
    @NSManaged public var isFav: Bool

}
