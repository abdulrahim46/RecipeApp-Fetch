//
//  NetworkService.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/16/25.
//

import Foundation

// MARK: - NetworkService
final class NetworkService: NetworkServiceProtocol {
    
    func fetchData<T: Decodable>(from urlString: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NSError(domain: "InvalidData", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode data."])
        }
    }
}
