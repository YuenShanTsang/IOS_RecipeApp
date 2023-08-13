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
    
    // Get the managed object context from the AppDelegate
    private var managedObjectContext: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // Save a new user recipe to Core Data
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
    
    // Fetch all user recipes from Core Data
    func fetchUserRecipes() -> [UserRecipe] {
        // Initialize an empty array to store fetched user recipes
        var userRecipes: [UserRecipe] = []
        
        // Create a fetch request for the RecipeEntity managed object
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        
        // Set a predicate to filter out RecipeEntity objects where userMeal is not nil
        fetchRequest.predicate = NSPredicate(format: "userMeal != nil")
        
        do {
            // Fetch user recipes from Core Data using the fetch request
            let fetchedUserRecipes = try managedObjectContext.fetch(fetchRequest)
            
            // Loop through the fetched RecipeEntity objects and create UserRecipe objects
            for entity in fetchedUserRecipes {
                // Extract attributes from the fetched entity
                if let userMeal = entity.userMeal,
                   let userCategory = entity.userCategory,
                   let userArea = entity.userArea,
                   let userIngredients = entity.userIngredients,
                   let userInstructions = entity.userInstructions,
                   let userRecipeImage = entity.userRecipeImage {
                    
                    // Create a UserRecipe object using the extracted attributes
                    let userRecipe = UserRecipe(
                        userMeal: userMeal,
                        userCategory: userCategory,
                        userArea: userArea,
                        userIngredients: userIngredients,
                        userInstructions: userInstructions,
                        userRecipeImage: userRecipeImage
                    )
                    
                    // Add the created UserRecipe object to the userRecipes array
                    userRecipes.append(userRecipe)
                }
            }
        } catch {
            // Handle any errors that occur during fetching
            print("Failed to fetch user recipes: \(error)")
        }
        
        // Return the array of fetched UserRecipe objects
        return userRecipes
        
    }
    
    // Delete a user recipe from Core Data
    func deleteUserRecipe(userRecipe: UserRecipe) {
        // Create a fetch request for the RecipeEntity managed object
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = RecipeEntity.fetchRequest()
        
        // Set a predicate to match the attributes of the user recipe to be deleted
        fetchRequest.predicate = NSPredicate(format: "userMeal == %@ AND userCategory == %@ AND userArea == %@ AND userIngredients == %@ AND userInstructions == %@",
            userRecipe.userMeal, userRecipe.userCategory, userRecipe.userArea,
            userRecipe.userIngredients, userRecipe.userInstructions)
        
        // Create a batch delete request using the fetch request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            // Execute the batch delete request to remove the user recipe from Core Data
            try managedObjectContext.execute(batchDeleteRequest)
            
            // Save the managed object context to persist the changes
            try managedObjectContext.save()
            
            // Print a success message
            print("User recipe deleted successfully!")
        } catch {
            // Handle any errors that occur during the deletion process
            print("Failed to delete user recipe: \(error)")
        }
    }
    
}
