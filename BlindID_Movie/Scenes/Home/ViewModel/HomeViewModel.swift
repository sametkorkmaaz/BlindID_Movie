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
    @Published var likedMovieIDs: Set<Int> = []

    let constants = HomeViewConstants()

    func loadAll() async {
        isLoading = true
        await loadLikedMovies()
        await loadMovies()
        isLoading = false
    }

    func loadMovies() async {
        do {
            let result = try await BlindService().fetchAllMovies()
            self.movies = result
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    func loadLikedMovies() async {
        do {
            let liked = try await BlindService().fetchLikedMovies()
            self.likedMovieIDs = Set(liked.compactMap { $0.id })
        } catch {
            print("Liked movie fetch error: \(error.localizedDescription)")
        }
    }

    func toggleLike(for movieId: Int?) async {
        guard let id = movieId else { return }

        do {
            if likedMovieIDs.contains(id) {
                _ = try await BlindService().unLikeMovieById(id)
                likedMovieIDs.remove(id)
            } else {
                _ = try await BlindService().likeMovieById(id)
                likedMovieIDs.insert(id)
            }
        } catch {
            print("Like/unlike error: \(error.localizedDescription)")
        }
    }
}
