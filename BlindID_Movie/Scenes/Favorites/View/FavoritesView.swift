//
//  FavoritesView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI
import Kingfisher

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBG.ignoresSafeArea()

                if viewModel.isLoading {
                    BlindAnimationView()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Favorites")
                            .font(FontManager.poppinsSemiBold(size: 32))
                            .foregroundColor(.orangeO50)
                            .padding(.horizontal)
                            .padding(.vertical)

                        Divider()
                            .background(Color.blueB10)
                            .frame(height: 1)
                            .padding(.bottom, 8)

                        if viewModel.likedMovies.isEmpty {
                            Spacer()
                            EmptyStateView(messageText: "Henüz favorilere film eklenmedi.")
                            Spacer()
                        } else {
                            ScrollView {
                                VStack(spacing: 12) {
                                    ForEach(viewModel.likedMovies) { movie in
                                        NavigationLink(destination: MovieDetailView(movieId: movie.id ?? 0)) {
                                            FavoriteRow(movie: movie)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await viewModel.loadLikedMovies()
        }
    }
}

struct FavoriteRow: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: movie.poster_url ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 90)
                .cornerRadius(8)
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title ?? "Untitled")
                    .foregroundColor(.white)
                    .font(.headline)

                Text(movie.category ?? "-")
                    .foregroundColor(.grayG30)
                    .font(.subheadline)

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orangeO50)
                    Text(String(format: "%.1f", movie.rating ?? 0.0))
                        .foregroundColor(.orangeO50)
                        .font(.subheadline)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.grayG30)
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }
}

#Preview {
    FavoritesView()
}
