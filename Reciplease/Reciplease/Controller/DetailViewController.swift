//
//  RecipListViewController.swift
//  Reciplease
//
//  Created by yakoub on 24/09/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import UIKit
import SafariServices
import CoreData

class DetailViewController: UIViewController {

    var myRecipe: Recipe!
    var imageCache: [URL: UIImage?] = [:]
    var favoritRecipes = [FavoritRecipe]()
    var allFavoritRecipes = [FavoritRecipe]()
    var isFav: Bool = false
    var isAlreadyFav: Bool = false

    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var ingredientsLabel: UITextView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoritButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        addGraphic()
        detail()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           let fetchRequest: NSFetchRequest<FavoritRecipe> = FavoritRecipe.fetchRequest()
           do {
               let allFavoriteRecipes =  try PersistenceService.context.fetch(fetchRequest)
               self.allFavoritRecipes = allFavoriteRecipes
           } catch {
               return
           }
        alreadyFav()
    }

    @IBAction func getDirections(_ sender: Any) {
        let vc = SFSafariViewController(url: myRecipe.url)
        present(vc, animated: true, completion: nil)
    }

    private func detail() {
        timeLabel.text = myRecipe.correctTime
        if let cachedImage = imageCache[myRecipe.imageUrl] {
            myRecipe.myImage = cachedImage!
        }
        displayIngredients()
        recipeImage.image = myRecipe.myImage
        recipeLabel.text = myRecipe.label
    }

    private func displayIngredients() {
        for ingredient in myRecipe.ingredientLines {
            ingredientsLabel.text += "- \(ingredient)\n"
        }
    }

    private func addGraphic() {
        detailView.layer.shadowRadius = 30
        detailView.layer.cornerRadius = 5
        detailView.layer.borderWidth = 1.0
        detailView.layer.borderColor = UIColor.black.cgColor
        recipeImage.layer.borderWidth = 2.0
        recipeImage.layer.borderColor = UIColor.black.cgColor
        getDirectionsButton.layer.cornerRadius = 15
    }
}

extension DetailViewController {
    
    private func saveRecipe() {
        isAlreadyFav = true
        favoritButton.tintColor = UIColor .yellow
        let saveFavRecipe = FavoritRecipe(context: PersistenceService.context)
        saveFavRecipe.correctTime = myRecipe.correctTime
        saveFavRecipe.labelRecipe = myRecipe.label
        saveFavRecipe.ingredientsLines = myRecipe.ingredientLines as [NSString]
        let data = (myRecipe?.myImage)!.pngData()
        saveFavRecipe.imageRecipe = data
        saveFavRecipe.urlRecipe = myRecipe.url
        saveFavRecipe.isFav = true
        PersistenceService.saveContext()
        favoritRecipes.append(saveFavRecipe)
        let fVc = FavoriteListViewController(nibName: "FavoriteListViewController", bundle: nil)
        fVc.favoritRecipes = favoritRecipes
    }
    
    
    @IBAction func favoritRecipe(_ sender: Any) {
        if isFav != true && isAlreadyFav != true {
            saveRecipe()
        } else {
            alertAlreadyFav()
        }
    }
    
    private func alertAlreadyFav() {
        let alertVc = UIAlertController(title: "Info", message: "This recipe is already in your favorit list", preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }
    
    
    private func alreadyFav() {
        var i = 0
        if allFavoritRecipes.count != 0 {
            while (i < allFavoritRecipes.count) {
                if (myRecipe.url == allFavoritRecipes[i].urlRecipe) {
                    favoritButton.tintColor = UIColor .yellow
                    isFav = true
                }
            i += 1
            }
        }
    }
}
