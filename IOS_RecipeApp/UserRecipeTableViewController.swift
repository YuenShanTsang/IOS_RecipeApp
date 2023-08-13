//
//  UserRecipeTableViewController.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 12/8/2023.
//

import UIKit

class UserRecipeTableViewController: UITableViewController {
    
    var userRecipes: [UserRecipe] = []
    var recipeDataHelper = RecipeDataHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userRecipes = RecipeDataHelper().fetchUserRecipes()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userRecipeCell", for: indexPath) as! UserRecipeTableViewCell
        
        // Configure the custom cell with user recipe data
        let userRecipe = userRecipes[indexPath.row]
        cell.userMealLabel.text = userRecipe.userMeal
        cell.userCategoryLabel.text = userRecipe.userCategory
        
        if let imageData = userRecipe.userRecipeImage, let image = UIImage(data: imageData) {
            cell.userRecipeImage.image = image
        }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let deletedUserRecipe = userRecipes[indexPath.row]
            RecipeDataHelper().deleteUserRecipe(userRecipe: deletedUserRecipe) // Delete from Core Data
            userRecipes.remove(at: indexPath.row) // Delete from the array
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showUserRecipeDetails",
           let destinationVC = segue.destination as? UserRecipeDetailsViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            let selectedRecipe = userRecipes[selectedIndexPath.row]
            destinationVC.selectedUserRecipe = selectedRecipe
        }
    }
    
    
}
