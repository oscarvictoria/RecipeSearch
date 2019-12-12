//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by Oscar Victoria Gonzalez  on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    
    func configured(for recipe: Recipe) {
        recipeLabel.text = recipe.label
        // Set image for recipe
        recipeImageView.getImage(with: recipe.image) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let image):
                //
                DispatchQueue.main.async {
                    self.recipeImageView.image = image
                }
            }
        }
    }

}
