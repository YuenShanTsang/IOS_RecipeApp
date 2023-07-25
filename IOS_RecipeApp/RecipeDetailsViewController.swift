//
//  RecipeDetailsViewController.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 22/7/2023.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedRecipe = recipe {
            updateUI(with: selectedRecipe)
        } else {
            print("No recipe data received.")
        }
    }
    
    private func updateUI(with recipe: Recipe) {
        mealLabel.text = recipe.strMeal
        categoryLabel.text = "Category: " + recipe.strCategory
        areaLabel.text = "Area: " + recipe.strArea
        
        if let imageURL = URL(string: recipe.strMealThumb) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                } else {
                    // Set a placeholder image if the image is not available or there was an error loading it
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        } else {
            // Set a placeholder image if the image URL is not valid
            imageView.image = UIImage(named: "placeholder")
        }
        
        // Combine ingredients and measures into a single string
        var ingredientsString = ""
        for i in 0..<recipe.ingredientsAndMeasures.count {
            let ingredient = recipe.ingredientsAndMeasures[i]
            if !ingredient.isEmpty {
                if !ingredientsString.isEmpty {
                    ingredientsString += "\n"
                }
                ingredientsString += ingredient
            }
        }
        ingredientLabel.text = ingredientsString
        instructionsLabel.text = recipe.strInstructions
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     
     }
     */
    
}
