//
//  RecipeViewModelTests.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/19/25.
//

import XCTest
@testable import RecipeApp

@MainActor
final class RecipeViewModelTests: XCTestCase {
    var viewModel: RecipeViewModel!
    var mockService: MockNetworkService!
    var mockRepository: RecipeRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        mockRepository = RecipeRepository(networkService: mockService)
        viewModel = RecipeViewModel(repository: mockRepository)
    }
    
    func testLoadRecipesSuccess() async {
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
        
        await viewModel.loadRecipes()
        
        XCTAssertFalse(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.recipes.first?.name, "Apam Balik")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoadRecipesEmpty() async {
        let jsonData = "{}".data(using: .utf8)!
        mockService.mockData = jsonData
        
        await viewModel.loadRecipes()
        
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "The data couldn’t be read because it is missing.")
    }
    
    func testLoadRecipesFailure() async {
        mockService.shouldReturnError = true
        
        await viewModel.loadRecipes()
        
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Mock Error")
    }
}
