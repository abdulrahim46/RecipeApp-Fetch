//
//  RecipeRowView.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/17/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    @State private var image: UIImage?
    @StateObject private var viewModel = RecipeRowViewModel()

    var body: some View {
        HStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                ProgressView()
                    .frame(width: 60, height: 60)
                    .task {
                        await viewModel.loadImage(from: URL(string: recipe.photoUrlSmall!))
                    }
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name ?? "").font(.headline)
                Text(recipe.cuisine ?? "").font(.subheadline).foregroundColor(.gray)
            }
        }
    }
}
