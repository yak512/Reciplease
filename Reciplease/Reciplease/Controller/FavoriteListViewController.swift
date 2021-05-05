//
//  FavoriteListViewController.swift
//  Reciplease
//
//  Created by yakoub on 24/09/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import UIKit
import CoreData

class FavoriteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavoriteLabel: UILabel!
    
    var favoritRecipes = [FavoritRecipe]()
    var dataService = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        favoritRecipes = dataService.loadFavoriteRecipes()
        if favoritRecipes.count != 0 {
            noFavoriteLabel.isHidden = true
        } else {
            noFavoriteLabel.isHidden = false
        }
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
}

extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let favRecipe = favoritRecipes[indexPath.row]
        let ingredientLine = favRecipe.ingredientsLines as [String]
        cell.configure(image: UIImage(data: favRecipe.imageRecipe!)!, recipeTitle: favRecipe.labelRecipe!, ingredients: ingredientLine[0], time: favRecipe.correctTime!)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToFavDetail", sender: self)
    }
}

extension FavoriteListViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "segueToFavDetail" {
                let favDetVC = segue.destination as! FavoritDetailViewController
                favDetVC.favoriteRecipes = favoritRecipes[indexPath.row]
            }
        }
    }
}
