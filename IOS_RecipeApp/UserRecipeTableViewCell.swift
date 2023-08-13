//
//  UserRecipeTableViewCell.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 12/8/2023.
//

import UIKit

class UserRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var userRecipeImage: UIImageView!
    @IBOutlet weak var userMealLabel: UILabel!
    @IBOutlet weak var userCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
