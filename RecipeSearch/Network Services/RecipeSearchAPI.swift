//
//  RecipeSearchAPI.swift
//  RecipeSearch
//
//  Created by Oscar Victoria Gonzalez  on 12/10/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct RecipeSearchAPI {
    static func fetchRecipe(for searchQuery: String, completion: @escaping (Result<[Recipe], AppError>)-> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "tacos"
        let recipeEndpointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appKey)&from=0&to=50"
        
        guard let url = URL(string: recipeEndpointURL) else {
            completion(.failure(.badURL(recipeEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    var array = [Recipe]()
                    let SearchResults = try JSONDecoder().decode(RecipeSearch.self, from: data)
                    let theArray = SearchResults.hits
                    for label in theArray {
                        array.append(label.recipe)
                    }
                    completion(.success(array))
                    
                    // TODO: Use searchResults to createnan array of recipes
                    // TODO: Capture the array of recipes in the completion handler.
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
