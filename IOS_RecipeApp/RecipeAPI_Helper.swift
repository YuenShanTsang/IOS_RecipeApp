//
//  RecipeAPI_Helper.swift
//  IOS_RecipeApp
//
//  Created by Yuen Shan Tsang on 22/7/2023.
//

import Foundation

// Handles error types related to the Recipe API
enum RecipeAPI_Errors: Error {
    case cannotConvertURL
    case networkError(Error)
    case decodingError(Error)
}

// Helper class for interacting with the Recipe API
class RecipeAPI_Helper {
    
    // Base URL for fetching random recipes
    private static var baseURLString = "https://www.themealdb.com/api/json/v1/1/random.php"
    
    // Asynchronously fetch data from a URL
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
    
    // Fetch a list of random recipes asynchronously
    public static func fetchRandomRecipeList(count: Int) async throws -> [Recipe] {
        var recipes: [Recipe] = []
        
        do {
            // Fetch random recipes and decode them into RecipeResponse
            for _ in 0..<count {
                let data = try await fetch(urlString: baseURLString)
                let decoder = JSONDecoder()
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                recipes.append(contentsOf: recipeResponse.meals)
            }
            return recipes
        } catch {
            throw RecipeAPI_Errors.decodingError(error)
        }
    }
}

// New RecipeResponse struct to handle the response from the API
struct RecipeResponse: Codable {
    let meals: [Recipe]
}
