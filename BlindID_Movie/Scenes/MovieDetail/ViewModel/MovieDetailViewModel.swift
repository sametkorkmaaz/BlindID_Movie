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
    @Published var isLiked: Bool = false

    func fetchMovie(by id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            let fetchedMovie = try await BlindService().fetchMovieById(id)
            self.movie = fetchedMovie

            // Liked kontrolü
            let likedMovies = try await BlindService().fetchLikedMovies()
            self.isLiked = likedMovies.contains(where: { $0.id == id })
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func toggleLike(for movieId: Int) async {
        do {
            if isLiked {
                _ = try await BlindService().unLikeMovieById(movieId)
                isLiked = false
            } else {
                _ = try await BlindService().likeMovieById(movieId)
                isLiked = true
            }
        } catch {
            print("Like/unlike error:", error.localizedDescription)
        }
    }
}
