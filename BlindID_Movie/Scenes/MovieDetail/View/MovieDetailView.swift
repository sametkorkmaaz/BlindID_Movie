//
//  MovieDetailView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var viewModel = MovieDetailViewModel()
    @State private var isLiked: Bool = false

    var body: some View {
        ZStack {
            Color.darkBG.ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else if let movie = viewModel.movie {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ZStack(alignment: .bottomTrailing) {
                            AsyncImage(url: URL(string: movie.poster_url ?? "")) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                Color.darkBG
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 280)
                            .cornerRadius(12)

                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orangeO50)
                                Text(String(format: "%.1f", movie.rating ?? 0.0))
                                    .foregroundColor(.orangeO50)
                                    .font(.subheadline)
                            }
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                            .padding(10)
                        }

                        Text(movie.title ?? "Unknown Title")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Category: \(movie.category ?? "-")")
                            .foregroundColor(.grayG30)

                        Text("Year: \(movie.year ?? 0)")
                            .font(.subheadline)

                        if let actors = movie.actors {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Actors:")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)

                                ForEach(actors, id: \.self) { actor in
                                    Text(actor)
                                        .font(FontManager.poppinsRegular(size: 18))
                                        .foregroundColor(.blueB10)
                                }
                            }
                        }

                        Text(movie.description ?? "")
                            .font(.body)
                            .padding(.top, 8)
                    }
                    .foregroundColor(.white)
                    .padding()
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        if let id = viewModel.movie?.id {
                            await viewModel.toggleLike(for: id)
                        }
                    }
                }) {
                    Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(.orangeO50)
                }
            }
        }
        .task {
            await viewModel.fetchMovie(by: movieId)
        }
    }
}

#Preview {
    MovieDetailView(movieId: 2)
}
