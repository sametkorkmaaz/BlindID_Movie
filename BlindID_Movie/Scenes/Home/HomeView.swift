//
//  HomeView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack {
            Color.darkBG.ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView("Loading movies...")
            } else if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    Text("All Movies")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding([.top, .horizontal])

                    Divider()
                        .background(Color.blueB10)

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.movies) { movie in
                                MovieGridItem(movie: movie)
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


struct MovieGridItem: View {
    let movie: Movie

    private let itemWidth = (UIScreen.main.bounds.width - 3 * 16) / 2

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                print("Tapped on \(movie.title ?? "")")
            } label: {
                if let moviePosterURL = movie.poster_url {
                    AsyncImage(url: URL(string: moviePosterURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: itemWidth, height: itemWidth * 1.5)
                    .clipped()
                    .cornerRadius(12)
                }
            }

            Image("heartIcon")
                .renderingMode(.template)
                .padding(6)
                .foregroundColor(.orangeO50)
                .background(.white.opacity(0.8))
                .clipShape(Circle())
                .padding(6)
        }
    }
}

#Preview {
    HomeView()
}
