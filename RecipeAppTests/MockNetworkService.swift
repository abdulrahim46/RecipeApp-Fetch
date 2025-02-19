//
//  MockNetworkService.swift
//  RecipeAppTests
//
//  Created by Abdul Choudhary on 2/18/25.
//

import XCTest
@testable import RecipeApp

final class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockData: Data?
    
    func fetchData<T: Decodable>(from urlString: String, responseType: T.Type) async throws -> T {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock Error"])
        }
        
        guard let data = mockData else {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Data"])
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
