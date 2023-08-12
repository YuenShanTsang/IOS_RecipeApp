//
//  RecipeDataHelper.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 12/8/2023.
//

import Foundation
import CoreData
import UIKit

class RecipeDataHelper {

    private var managedObjectContext: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func saveUserRecipe(userRecipe: UserRecipe) {
        // Create a new UserRecipeEntity managed object
        let newUserRecipe = RecipeEntity(context: managedObjectContext)
        
        // Set attributes from the UserRecipe struct
        newUserRecipe.userMeal = userRecipe.userMeal
        newUserRecipe.userCategory = userRecipe.userCategory
        newUserRecipe.userArea = userRecipe.userArea
        newUserRecipe.userIngredients = userRecipe.userIngredients
        newUserRecipe.userInstructions = userRecipe.userInstructions
        
        do {
            try managedObjectContext.save()
            print("User recipe saved successfully!")
        } catch {
            print("Failed to save user recipe: \(error)")
        }
    }

    // Add methods to fetch, update, and delete user recipes as needed
}
