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
        categoryLabel.text = recipe.strCategory
        areaLabel.text = recipe.strArea

        // Combine ingredients and measures into a single string
        var ingredientsString = ""
        for i in 0..<recipe.ingredientsAndMeasures.count {
            let ingredient = recipe.ingredientsAndMeasures[i]
            if !ingredient.isEmpty {
                if !ingredientsString.isEmpty {
                    ingredientsString += ", "
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
