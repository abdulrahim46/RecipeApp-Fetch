//
//  NetworkServiceTests.swift
//  RecipeAppTests
//
//  Created by Abdul Choudhary on 2/18/25.
//

import XCTest
@testable import RecipeApp

final class NetworkServiceTests: XCTestCase {
    var repository: RecipeRepository!
    var mockService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        repository = RecipeRepository(networkService: mockService)
    }
    
    func testGetRecipesSuccess() async {
        let jsonData = """
        {
            "recipes": [
                {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                },
                {
                    "cuisine": "British",
                    "name": "Apple & Blackberry Crumble",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                    "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                    "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                }]
        }
        """.data(using: .utf8)!
        
        mockService.mockData = jsonData
        
        do {
            let recipes = try await repository.getRecipes()
            XCTAssertEqual(recipes.recipes.count, 2)
            XCTAssertEqual(recipes.recipes.first?.name, "Apam Balik")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testGetRecipesFailure() async {
        mockService.shouldReturnError = true
        
        do {
            _ = try await repository.getRecipes()
            XCTFail("Expected failure but succeeded")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Mock Error")
        }
    }
}
