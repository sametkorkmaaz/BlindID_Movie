//
//  HomeViewModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func loadMovies() async {
        isLoading = true
        do {
            let result = try await BlindService().fetchAllMovies()
            self.movies = result
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
