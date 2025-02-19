//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/17/25.
//

import Foundation

// MARK: - RecipeViewModel
@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private let repository: RecipeRepositoryProtocol
    
    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadRecipes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedRecipes = try await repository.getRecipes()
            
            if fetchedRecipes.recipes.isEmpty {
                errorMessage = "No recipes available."
            } else {
                recipes = fetchedRecipes.recipes
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
