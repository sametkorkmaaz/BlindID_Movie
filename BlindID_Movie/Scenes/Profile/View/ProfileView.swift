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
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
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
                            .foregroundColor(.red)
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name: \(user.name ?? "-")")
                            Text("Surname: \(user.surname ?? "-")")
                            Text("Email: \(user.email ?? "-")")
                            Text("Liked Movies: \(user.likedMovies?.count ?? 0)")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        Spacer()

                        Button("Edit") {
                            // edit işlemi sonra yapılacak
                            print("Edit tapped")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)

                        Spacer()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .task {
            await viewModel.fetchUserData()
        }
    }
}

#Preview {
    ProfileView()
}
