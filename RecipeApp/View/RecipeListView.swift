//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/17/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel: RecipeViewModel

    init(viewModel: @autoclosure @escaping () -> RecipeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.recipes) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                }
            }
            .navigationTitle("Recipes")
        }
        .task {
            await viewModel.loadRecipes()
        }
        .refreshable {
            await viewModel.loadRecipes()
        }
    }
}




