//
//  RecipeRowViewModel.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/17/25.
//

import SwiftUI
import UIKit

@MainActor
class RecipeRowViewModel: ObservableObject {
    @Published var image: UIImage?
    
    private let imageCache = ImageCache.shared
    
    func loadImage(from url: URL?) async {
        guard let url = url else { return }
        do {
            let loadedImage = try await imageCache.loadImage(from: url)
            self.image = loadedImage
        } catch {
            print("Failed to load image for \(url): \(error)")
        }
    }
}

