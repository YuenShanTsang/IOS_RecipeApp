//
//  RecipeList.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 22/7/2023.
//

import Foundation

struct RecipeList: Codable {
    let meals: [Recipe]
}
struct Recipe: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
}
