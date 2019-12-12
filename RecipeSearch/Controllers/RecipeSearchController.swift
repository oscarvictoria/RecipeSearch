//
//  RecipeSearchController.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeSearchController: UIViewController {
    // TODO: we need a table view
    // TODO: we need a recipes array
    // TODO: on the recipes array have a didSet{} to update the table view
    // TODO: in the cellForRow show the recipes: label.
    //  TODO: RecipeSearchAPI.fetchImage("Chrsitmas cookies") {...} accessing data populate
    // recipes array e.g "christmas cookies"
    
@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var searchBar: UISearchBar!
    
    var recipes = [Recipe]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadRecipes()
        
    }
    
    func loadRecipes() {
        RecipeSearchAPI.fetchRecipe(for: "tacos") { (result) in
            switch result {
            case .failure(let error):
                print("Error \(error)")
            case .success(let recipe):
                DispatchQueue.main.async {
                    self.recipes = recipe
                }
            }
        }
    }
    
}

extension RecipeSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCell else {
            fatalError("error")
        }
        let theRecipes = recipes[indexPath.row]
        cell.configured(for: theRecipes)
        return cell
    }
    
}

extension RecipeSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        RecipeSearchAPI.fetchRecipe(for: searchText) { (result) in
                 switch result {
                 case .failure(let error):
                     print("Error \(error)")
                 case .success(let recipe):
                     DispatchQueue.main.async {
                         self.recipes = recipe
                     }
                 }
             }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard let searchText = searchBar.text else { return }
//        RecipeSearchAPI.fetchRecipe(for: searchText) { (result) in
//                 switch result {
//                 case .failure(let error):
//                     print("Error \(error)")
//                 case .success(let recipe):
//                     DispatchQueue.main.async {
//                         self.recipes = recipe
//                     }
//                 }
//             }
//    }
}
}

extension RecipeSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
