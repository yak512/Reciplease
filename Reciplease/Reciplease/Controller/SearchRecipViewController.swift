//
//  SearchRecipViewController.swift
//  Reciplease
//
//  Created by yakoub on 24/09/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import UIKit
import Alamofire

class SearchRecipViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var IngredientsTextField: UITextField!
    @IBOutlet weak var IngredientsTextView: UITextView!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    var searchRecipes = RecipesService()
    var allRecipes: [Recipe]!
    var ingredients: String!
    var imageCache: [URL: UIImage?] = [:]

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        roundButtons()
        super.viewDidLoad()

    }

    // MARK: - Actions
    @IBAction func dismissKeyboard(_ sender: Any) {
        IngredientsTextField.resignFirstResponder()
    }
    
    @IBAction func searchForRecipes(_ sender: Any) {
        if IngredientsTextView.text == "" {
            presentAlert(title: "Error", message: "No ingredients in the list")
        } else {
            displayButtonAndActivityIndicator(isHiden: true)
            searchRecipes.mySearchRecipes(ingredients: ingredients) { (recipes, response) in
                if recipes?.count == 0 && response == true {
                    self.presentAlert(title: "Info", message: "No Recipes found, please try other ingredients")
                    self.displayButtonAndActivityIndicator(isHiden: false)
                } else if response, let recipes = recipes {
                    self.allRecipes = recipes
                    self.performSegue(withIdentifier: "segueToRecipes", sender: self)
                    self.displayButtonAndActivityIndicator(isHiden: false)
                } else {
                    self.presentAlert(title: "Error", message: "Please check your network conenction")
                    self.displayButtonAndActivityIndicator(isHiden: false)
                }
            }
        }
    }

    @IBAction func addIngredient(_ sender: Any) {
        if IngredientsTextField.text != "" {
            IngredientsTextView.text! += "  - " + IngredientsTextField.text! + "\n\n"
            ingredients = IngredientsTextView.text!
            IngredientsTextField.text = ""
        }
    }

    @IBAction func clearIngredients(_ sender: Any) {
        IngredientsTextView.text = ""
    }
    
    
    // MARK: - Helpers
    private func roundButtons() {
        SearchButton.layer.cornerRadius = 15
        addButton.layer.cornerRadius = 10
        clearButton.layer.cornerRadius = 10
    }
    
    

    func displayButtonAndActivityIndicator(isHiden: Bool) {
        SearchButton.isHidden = isHiden
        ActivityIndicator.isHidden = !isHiden
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipes" {
            let recipesVC = segue.destination as! RecipesListViewController
            recipesVC.allRecipes = allRecipes!
            recipesVC.imageCache = imageCache
        }
    }

    private func presentAlert(title: String, message: String) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }

}

