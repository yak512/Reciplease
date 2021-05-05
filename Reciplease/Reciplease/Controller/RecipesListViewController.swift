//
//  ListViewController.swift
//  Reciplease
//
//  Created by yakoub on 28/09/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {

    // MARK: - Properties
    var allRecipes: [Recipe]!
    var recipService = RecipesService()
    var imageCache: [URL: UIImage?] = [:]

    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
    
    // MARK: - UITableViewDelegate
extension RecipesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }

        var recipe = allRecipes[indexPath.row]
        cell.imageView?.image = nil

        if let cachedImage = imageCache[recipe.imageUrl] {
            recipe.myImage = cachedImage!
            cell.configure(image: recipe.myImage, recipeTitle: recipe.label, ingredients: recipe.ingredientLines[0], time: recipe.correctTime)
            cell.setNeedsLayout()
        } else {
                recipService.imageFrom(url: recipe.imageUrl) { (data, error) in
                guard error == nil else {
                    return
                }
                let myImage = UIImage(data: data!)
                self.imageCache[recipe.imageUrl] = myImage
                cell.imageView?.image = nil
                cell.configure(image: myImage!, recipeTitle: recipe.label, ingredients: recipe.ingredientLines[0], time: recipe.correctTime)
                cell.setNeedsLayout()
                }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        performSegue(withIdentifier: "segueToDetail", sender: self)
    }
}


extension RecipesListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "segueToDetail" {
                let DetailVC = segue.destination as! DetailViewController
                DetailVC.myRecipe = allRecipes[indexPath.row]
                DetailVC.imageCache = imageCache
            }
        }
    }
}
