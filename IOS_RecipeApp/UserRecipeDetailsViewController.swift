//
//  UserRecipeDetailsViewController.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 13/8/2023.
//

import UIKit

class UserRecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedUserRecipe: UserRecipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check if a user recipe is selected
        if let recipe = selectedUserRecipe {
            // Update UI with selected user recipe details
            mealLabel.text = recipe.userMeal
            categoryLabel.text = "Category: " + recipe.userCategory
            areaLabel.text = "Area: " + recipe.userArea
            ingredientLabel.text = recipe.userIngredients
            instructionsLabel.text = recipe.userInstructions
            
            // Display the user recipe image if available
            if let imageData = recipe.userRecipeImage {
                imageView.image = UIImage(data: imageData)
            } else {
                // Set a placeholder image if the image data is not available
                imageView.image = UIImage(named: "placeholderImage")
            }
        } else {
            print("No user recipe data received.")
        }
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
