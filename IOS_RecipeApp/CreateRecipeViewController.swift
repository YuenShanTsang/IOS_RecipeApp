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
