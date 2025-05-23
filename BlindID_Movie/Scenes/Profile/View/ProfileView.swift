//
//  ProfileView.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = true

    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBG.ignoresSafeArea()

                if viewModel.isLoading {
                    BlindAnimationView()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else if let user = viewModel.userData {
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)

                            Spacer()

                            Button("Logout") {
                                isLoggedIn = false
                            }
                            .foregroundColor(.orange)
                        }
                        .padding()

                        VStack(spacing: 12) {
                            ProfileInfoCard(title: "Name", value: user.name)
                            ProfileInfoCard(title: "Surname", value: user.surname)
                            ProfileInfoCard(title: "Email", value: user.email)
                            ProfileInfoCard(title: "Liked Movies", value: "\(user.likedMovies?.count ?? 0)")
                        }
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        Spacer()

                        NavigationLink(destination: EditProfileView().onDisappear {
                            Task {
                                await viewModel.fetchUserData()
                            }
                        }) {
                            Text("Edit")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blueB10)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchUserData()
        }
    }
}

struct ProfileInfoCard: View {
    let title: String
    let value: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.grayG30)

            Text(value ?? "-")
                .font(.body)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blueB10, lineWidth: 1)
        )
    }
}

#Preview {
    ProfileView()
}

