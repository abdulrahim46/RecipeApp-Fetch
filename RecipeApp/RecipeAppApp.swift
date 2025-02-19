//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/16/25.
//

import SwiftUI

@main
struct RecipeAppApp: App {
    
    let repository = RecipeRepository(networkService: NetworkService())
    
    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: RecipeViewModel(repository: repository))
        }
    }
}
