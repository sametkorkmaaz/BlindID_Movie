//
//  MovieDetailViewModel.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchMovie(by id: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedMovie = try await BlindService().fetchMovieById(id)
            self.movie = fetchedMovie
        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
