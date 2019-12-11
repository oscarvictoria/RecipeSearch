//
//  RecipeSearchAPITests.swift
//  RecipeSearchTests
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import XCTest
@testable import RecipeSearch

class RecipeSearchAPITests: XCTestCase {
    
    func testChristmasCookies() {
        // arrange
        // convert string to url friendly string
        let searchQuery = "christmas cookies".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let exp = XCTestExpectation(description: "search found")
        let recipeEndpointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appKey)&from=0&to=50"
        
        let request = URLRequest(url: URL(string: recipeEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let data):
                exp.fulfill()
                // assert
                XCTAssertGreaterThan(data.count, 800000)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
// TODO: Write an asyncchronous test to validate you do get back 50 recipes for the
    // "christmast cookie" search from the fetchRecipes method
    
    func testForFetchRecipes() {
        let expectedRecipeCount = 50
        let exp = XCTestExpectation(description: "recipes found")
        let searchQuery = "christmas cookies"
        
        // Act:
        RecipeSearchAPI.fetchRecipe(for: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let recipe):
                exp.fulfill()
                XCTAssertEqual(recipe.count , expectedRecipeCount)
            }
        }
        wait(for: [exp] , timeout: 5.0)
    }
}
