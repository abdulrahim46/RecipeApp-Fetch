//
//  Recipe.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/16/25.
//

import Foundation


// MARK: - RecipeResponse
// This struct will represent the top-level response from the JSON.
struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
// This struct represents each recipe object in the JSON.
struct Recipe: Codable, Identifiable {
    // Use UUID property as `id` for Identifiable conformance.
    var id: String { uuid }
    
    let cuisine: String?
    let name: String?
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let uuid: String
    let youtubeUrl: String?
    
    // Map the JSON keys to Swift property names using CodingKeys
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case uuid
        case youtubeUrl = "youtube_url"
    }
}
