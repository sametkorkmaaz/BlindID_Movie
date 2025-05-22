//
//  FavoritesViewModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var likedMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func loadLikedMovies() async {
        isLoading = true
        do {
            let result = try await BlindService().fetchLikedMovies()
            self.likedMovies = result
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
