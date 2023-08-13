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
    
    private let recipeDataHelper = RecipeDataHelper()
    
    @IBAction func imagePicker(_ sender: Any) {
        // Create an instance of UIImagePickerController
        let imagePicker = UIImagePickerController()
        
        // Set the source type of the image picker to use the photo library
        imagePicker.sourceType = .photoLibrary
        
        // Set the delegate of the image picker to this view controller
        imagePicker.delegate = self
        
        // Present the image picker modally, allowing the user to choose an image
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
        
        // Check if an image has been selected
        guard let selectedImage = image.image else {
            // Show an alert indicating that an image is required
            let alert = UIAlertController(title: "Missing Image", message: "Please select an image for the recipe.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Create a confirmation alert before submitting
        let confirmationAlert = UIAlertController(title: "Confirm Submission", message: "Are you sure you want to submit this recipe?", preferredStyle: .alert)
        
        // Add a cancel action
        confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add an OK action that triggers recipe submission
        confirmationAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Convert the selected image to Data
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
                print("Failed to convert image to data")
                return
            }
            
            // Create a UserRecipe object
            let newUserRecipe = UserRecipe(
                userMeal: meal,
                userCategory: category,
                userArea: area,
                userIngredients: ingredients,
                userInstructions: instructions,
                userRecipeImage: imageData
            )
            
            // Save the Core Data context
            self.recipeDataHelper.saveUserRecipe(userRecipe: newUserRecipe)
            
            // Navigate back to the home page
            self.navigationController?.popViewController(animated: true)
        }))
        
        // Present the confirmation alert
        present(confirmationAlert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // This function is called when the user cancels the image picker
        print("no image was selected so the library was dismissed")
        
        // Dismiss the image picker
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // This function is called when the user selects an image from the image picker
        
        // Extract the selected image from the info dictionary
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            // Unable to retrieve the selected image, handle the error or unexpected case
            return
        }
        
        // Set the selected image to the UIImageView
        self.image.image = selectedImage
        
        // Dismiss the image picker
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
