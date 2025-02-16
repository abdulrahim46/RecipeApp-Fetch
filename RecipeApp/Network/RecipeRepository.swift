//
//  RecipeRepository.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/16/25.
//

import Foundation

// MARK: - RecipeRepository
final class RecipeRepository: RecipeRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getRecipes() async throws -> RecipeResponse {
        return try await networkService.fetchData(from: ServiceURLs.recipesURL, responseType: RecipeResponse.self)
    }
}
