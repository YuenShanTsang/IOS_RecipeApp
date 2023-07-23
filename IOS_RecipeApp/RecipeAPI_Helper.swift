//
//  RecipeAPI_Helper.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 22/7/2023.
//

import Foundation

// Handles error
enum RecipeAPI_Errors: Error {
    case cannotConvertURL
    case networkError(Error)
    case decodingError(Error)
}

class RecipeAPI_Helper {
    private static var baseURLString = "https://www.themealdb.com/api/json/v1/1/random.php"
    
    public static func fetch(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw RecipeAPI_Errors.cannotConvertURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw RecipeAPI_Errors.networkError(error)
        }
    }
    
    public static func fetchRandomRecipeList(count: Int) async throws -> [Recipe] {
        var recipes: [Recipe] = []
        
        do {
            for _ in 0..<count {
                let data = try await fetch(urlString: baseURLString)
                let decoder = JSONDecoder()
                let recipeList = try decoder.decode(RecipeList.self, from: data)
                recipes.append(contentsOf: recipeList.meals)
            }
            
            return recipes
        } catch {
            throw RecipeAPI_Errors.decodingError(error)
        }
    }
}
