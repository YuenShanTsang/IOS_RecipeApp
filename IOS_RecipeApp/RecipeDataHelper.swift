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
        newUserRecipe.userRecipeImage = userRecipe.userRecipeImage
        
        do {
            try managedObjectContext.save()
            print("User recipe saved successfully!")
        } catch {
            print("Failed to save user recipe: \(error)")
        }
    }
    
    func fetchUserRecipes() -> [UserRecipe] {
        var userRecipes: [UserRecipe] = []
        
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userMeal != nil")
        
        do {
            let fetchedUserRecipes = try managedObjectContext.fetch(fetchRequest)
            
            for entity in fetchedUserRecipes {
                if let userMeal = entity.userMeal,
                   let userCategory = entity.userCategory,
                   let userArea = entity.userArea,
                   let userIngredients = entity.userIngredients,
                   let userInstructions = entity.userInstructions,
                   let userRecipeImage = entity.userRecipeImage {
                    
                    let userRecipe = UserRecipe(
                        userMeal: userMeal,
                        userCategory: userCategory,
                        userArea: userArea,
                        userIngredients: userIngredients,
                        userInstructions: userInstructions,
                        userRecipeImage: userRecipeImage
                    )
                    
                    userRecipes.append(userRecipe)
                }
            }
        } catch {
            print("Failed to fetch user recipes: \(error)")
        }
        
        return userRecipes
    }

}
