//
//  FavoritDetailViewController.swift
//  Reciplease
//
//  Created by yakoub on 03/10/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

class FavoritDetailViewController: UIViewController {

    // MARK: - properties
    var favoriteRecipes: FavoritRecipe!
    var dataService = DataService()
    var unFav = false
    
    // MARK: - Outlets
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var detailView: UIView!
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addGraphic()
        recipeDetail()
    }

    // MARK: - Actions
    @IBAction func unFavorite(_ sender: Any) {
        if unFav == false {
            unFav = true
            favoriteButton.tintColor = UIColor.white
            dataService.deleteRecipe(favoriteRecipes: favoriteRecipes)
        } else {
            alertAlreadyRemovedFromFav()
        }
    }

    @IBAction func getDirection(_ sender: Any) {
        let vc = SFSafariViewController(url: favoriteRecipes.urlRecipe!)
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    private func alertAlreadyRemovedFromFav() {
        let alertVc = UIAlertController(title: "Info", message: "This recipe has already been removed from your favorites list", preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }
    
    private func recipeDetail() {
        favoriteButton.tintColor = UIColor.yellow
        time.text = favoriteRecipes.correctTime
        imageRecipe.image = UIImage(data: favoriteRecipes.imageRecipe!)
        displayIngredients()
        recipeLabel.text = favoriteRecipes.labelRecipe
        
    }

    private func displayIngredients() {
        let ingredients = favoriteRecipes.ingredientsLines
        for ingredient in ingredients {
            ingredientsTextView.text += "- \(ingredient)\n"
        }
    }

    private func addGraphic() {
        detailView.layer.shadowRadius = 30
        detailView.layer.cornerRadius = 5
        detailView.layer.borderWidth = 1.0
        detailView.layer.borderColor = UIColor.black.cgColor
        imageRecipe.layer.borderWidth = 2.0
        imageRecipe.layer.borderColor = UIColor.black.cgColor
        getDirectionButton.layer.cornerRadius = 15
    }
}
