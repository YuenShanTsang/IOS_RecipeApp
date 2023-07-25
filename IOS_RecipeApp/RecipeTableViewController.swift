//
//  RecipeTableViewController.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 22/7/2023.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    var recipeList: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        Task {
            do {
                let randomRecipes = try await RecipeAPI_Helper.fetchRandomRecipeList(count: 20)
                recipeList = randomRecipes
                
                // Print some information to check the API response
                print("Number of recipes received: \(recipeList.count)")
                if let firstRecipe = recipeList.first {
                    print("First recipe name: \(firstRecipe.strMeal)")
                } else {
                    print("No recipe data received.")
                }
                
                tableView.reloadData()
            } catch {
                preconditionFailure("Program failed with error message \(error)")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        
        cell.textLabel!.text = recipeList[indexPath.row].strMeal
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    // In RecipeTableViewController.swift
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetails",
           let destinationVC = segue.destination as? RecipeDetailsViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            let selectedRecipe = recipeList[selectedIndexPath.row]
            print("Selected recipe: \(selectedRecipe)")
            destinationVC.recipe = selectedRecipe
        }
    }
    
    
    
}
