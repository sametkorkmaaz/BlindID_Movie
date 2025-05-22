//
//  HomeView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBG.ignoresSafeArea()

                if viewModel.isLoading {
                    ProgressView("Loading movies...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(viewModel.constants.homeViewTitleText)
                            .font(FontManager.poppinsSemiBold(size: 32))
                            .foregroundColor(.orangeO50)
                            .padding([.vertical, .horizontal])

                        Divider()
                            .background(Color.blueB10)
                            .frame(height: 1)

                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(destination: MovieDetailView(movieId: movie.id ?? 0)) {
                                        MovieGridItem(movie: movie)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .task {
                await viewModel.loadMovies()
            }
        }
    }
}

struct MovieGridItem: View {
    let movie: Movie

    private let itemWidth = (UIScreen.main.bounds.width - 3 * 16) / 2

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let posterURLString = movie.poster_url,
               let posterURL = URL(string: posterURLString) {
                
                KFImage(posterURL)
                    .resizable()
                    .cacheMemoryOnly()
                    .fade(duration: 0.1)
                    .scaledToFill()
                    .frame(width: itemWidth, height: itemWidth * 1.5)
                    .clipped()
                    .cornerRadius(12)
                    .background(.grayG30.opacity(0.1))
            }

            Image("heartIcon")
                .renderingMode(.template)
                .padding(6)
                .foregroundColor(.orangeO50)
                .background(.white.opacity(0.9))
                .clipShape(Circle())
                .padding(6)
        }
    }
}

#Preview {
    HomeView()
}
