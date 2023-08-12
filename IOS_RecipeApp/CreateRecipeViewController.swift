//
//  CreateRecipeViewController.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 5/8/2023.
//

import UIKit

class CreateRecipeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func imagePicker(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
//        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
//            imagePicker.sourceType = .camera
//        } else {
//            imagePicker.sourceType = .photoLibrary
//        }
        
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func submitUserRecipe(_ sender: Any) {
        // Get input values from text fields and text view
            let meal = mealTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let category = categoryTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let area = areaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let ingredients = ingredientsTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let instructions = instructionsTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            // Check if required fields are empty
            if meal.isEmpty || category.isEmpty || area.isEmpty || ingredients.isEmpty || instructions.isEmpty {
                // Show an alert indicating that all fields are required
                let alert = UIAlertController(title: "Missing Information", message: "Please fill in all fields.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            // Create a UserRecipe object
            let newUserRecipe = UserRecipe(
                userMeal: meal,
                userCategory: category,
                userArea: area,
                userIngredients: ingredients,
                userInstructions: instructions
            )
            
            // Save the user recipe using RecipeDataHelper
            let recipeDataHelper = RecipeDataHelper()
            recipeDataHelper.saveUserRecipe(userRecipe: newUserRecipe)
            
            // Navigate back to the home page
            navigationController?.popViewController(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("no image was selected so the library was dismissed")
        
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.image.image = image
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
