//
//  RecipesTableViewCell.swift
//  Reciplease
//
//  Created by yakoub on 28/09/2020.
//  Copyright © 2020 Yakoub. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    
    
    override func awakeFromNib() {
        addShadow()
        super.awakeFromNib()
    }
    
    private func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    func configure(image: UIImage, recipeTitle: String, ingredients: String, time: String) {
        recipeImageView.image = image
        recipeLabel.text = recipeTitle
        ingredientsLabel.text = ingredients
        timeLabel.text = time
    }
    
   private func addShadow() {

        detailView.layer.shadowRadius = 30
        detailView.layer.cornerRadius = 5
        recipeImageView.layer.cornerRadius = 15
        recipeImageView.layer.borderWidth = 2.0
        recipeImageView.layer.borderColor = UIColor.black.cgColor
        detailView.layer.borderWidth = 1.0
        detailView.layer.borderColor = UIColor.black.cgColor
    }

}

