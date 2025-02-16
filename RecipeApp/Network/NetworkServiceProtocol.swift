//
//  NetworkServiceProtocol.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/16/25.
//

import Foundation

// MARK: - Protocol for Network Service
protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from urlString: String, responseType: T.Type) async throws -> T
}

// MARK: - Protocol for Recipe Repository
protocol RecipeRepositoryProtocol {
    func getRecipes() async throws -> RecipeResponse
}
