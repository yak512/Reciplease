//
//  ListViewController.swift
//  Reciplease
//
//  Created by yakoub on 28/09/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {

    var allRecipes: [Recipe]!
    var recipService = RecipesService()
    var imageCache: [URL: UIImage?] = [:]
    //var detailImage: [UIImage] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}

var i = 0

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
           // print("AGAIN \(i)")
            recipe.myImage = cachedImage!
            cell.configure(image: recipe.myImage, recipeTitle: recipe.label, ingredients: recipe.ingredientLines[0], time: recipe.correctTime)
          cell.setNeedsLayout()
            } else {
            recipService.imageFrom(url: recipe.imageUrl) { (image, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
            i = i + 1
                print("number IMAGE -----> \(i) ---- > \(self.allRecipes[indexPath.row].myImage)")
                self.imageCache[recipe.imageUrl] = image
               // self.detailImage.append(image!)
              // if let cellToUpdate = self.tableView?.cellForRow(at: indexPath) as? RecipeTableViewCell {
                cell.imageView?.image = nil
                cell.configure(image: image!, recipeTitle: recipe.label, ingredients: recipe.ingredientLines[0], time: recipe.correctTime)
                cell.setNeedsLayout()
                   // }
                }
            }

         //cell.configure(image: recipe.myImage, recipeTitle: recipe.label, ingredients: recipe.ingredientLines[0], time: recipe.totalTime)
       // cell.setNeedsLayout()
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "segueToDetail" {
                let DetailVC = segue.destination as! DetailViewController
                DetailVC.myRecipe = allRecipes[indexPath.row]
                DetailVC.imageCache = imageCache
                print("******")
                print(allRecipes[indexPath.row].myImage)
                print("******\n")

                print(DetailVC.myRecipe.label)
                print(DetailVC.myRecipe.myImage)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        performSegue(withIdentifier: "segueToDetail", sender: self)
    }
    

}
