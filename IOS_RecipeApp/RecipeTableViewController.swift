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
        // self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        Task {
            do {
                let randomRecipes = try await RecipeAPI_Helper.fetchRandomRecipeList(count: 30)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        let recipe = recipeList[indexPath.row]
        cell.mealLabel.text = recipe.strMeal
        cell.categoryLabel.text = recipe.strCategory
        
        if let imageURL = URL(string: recipe.strMealThumb) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        cell.recipeImage.image = image
                    }
                } else {
                    // Set a placeholder image if the image is not available or there was an error loading it
                    DispatchQueue.main.async {
                        cell.recipeImage.image = UIImage(named: "placeholderImage")
                    }
                }
            }
        } else {
            // Set a placeholder image if the image URL is not valid
            cell.recipeImage.image = UIImage(named: "placeholderImage")
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Fetch the recipe for the cell at the given indexPath
        let recipe = recipeList[indexPath.row]
        
        // Calculate the height required to display the content of the labels
        let cellHeight = calculateCellHeight(for: recipe)
        
        // Return the calculated height
        return cellHeight
    }
    
    private func calculateCellHeight(for recipe: Recipe) -> CGFloat {
        // Get the cell's contentView width to determine label width
        let labelWidth = tableView.bounds.width - 16 // Adjust the value according to the cell's layout
        
        // Create NSAttributedString for the labels with the appropriate font
        let mealLabelAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)] // Change the font size accordingly
        let categoryLabelAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)] // Change the font size accordingly
        
        let mealLabelSize = NSString(string: recipe.strMeal).boundingRect(with: CGSize(width: labelWidth, height: .greatestFiniteMagnitude),options: .usesLineFragmentOrigin, attributes: mealLabelAttributes,context: nil)
        let categoryLabelSize = NSString(string: recipe.strCategory).boundingRect(with: CGSize(width: labelWidth, height: .greatestFiniteMagnitude),options: .usesLineFragmentOrigin,attributes: categoryLabelAttributes,context: nil)
        
        // Calculate the height needed for each label
        let mealLabelHeight = ceil(mealLabelSize.height)
        let categoryLabelHeight = ceil(categoryLabelSize.height)
        
        // Add additional spacing between the labels
        let spacing: CGFloat = 8
        
        // Return the total height of the cell, considering the heights of the labels and spacing
        return mealLabelHeight + categoryLabelHeight + spacing
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
            //recipeList.delete(at: indexPath)
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
